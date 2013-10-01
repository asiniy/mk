class PostsController < InheritedResources::Base
  before_filter :only_user!, only: [ :new, :create ]
  before_filter :only_admin!, only: [ :destroy ]
  actions :all, except: [ :edit, :update ]
  respond_to :html

  def index
    params[:category_ids] ||= Category.pluck(:id).map(&:to_s)

    if params[:search].present? && Rails.env.development?
      options = {}

      options[:category_ids] = params[:category_ids] if params[:category_ids].present?
      options[:tag_ids] = params[:tag_ids] if params[:tag_ids].present?

      @posts = Post.search(params[:search], excerpt_options: {limit: 100}, with: options, page: params[:page], per_page: 12)

      @excerpter = ThinkingSphinx::Excerpter.new 'post_core', params[:search], {
        :before_match    => '<span style="background:yellow">',
        :after_match     => '</span>',
        :chunk_separator => ' &#8230; ' # ellipsis
      }
    else
      @posts = Post
                 .published
                 .uniq
                 .order('"posts"."created_at" DESC')

      @posts = @posts
        .joins('INNER JOIN "categories_posts" ON "posts"."id" = "categories_posts"."post_id"')
        .where('"categories_posts"."category_id" in (?)', params[:category_ids])

      if params[:tag_ids].present?
        @posts = @posts
          .joins('INNER JOIN "taggings" ON "posts"."id" = "taggings"."taggable_id"')
          .where('"taggings"."tag_id" IN (?)', params[:tag_ids])
      end

      @posts = @posts.where('"posts"."body" ILIKE ? OR "posts"."heading" ILIKE ? OR "posts"."short_description" ILIKE ?',
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?

      @posts = @posts.paginate(page: params[:page], per_page: 12)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment
                  .where('"comments"."post_id" = ?', params[:id])
                  .includes(:user)
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.published = true if admin_signed_in?
    if @post.save
      if @post.published
        flash[:success] = 'Ваша статья опубликована'
      else
        flash[:notice] = 'Ваша статья сохранена, ожидайте проверки модератора'
      end
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    destroy! { root_path }
  end

  protected
  def post_params
    params.require(:post).permit(:heading, :short_description, :body, :tag_list, {category_ids: []})
  end
end

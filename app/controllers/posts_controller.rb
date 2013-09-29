class PostsController < InheritedResources::Base
  before_filter :only_user!, only: [ :new, :create ]
  before_filter :only_admin!, only: [ :destroy ]
  actions :all, except: [ :edit, :update ]
  respond_to :html

  def index
    params[:category_ids] ||= Category.pluck(:id)

    if params[:search].present? && Rails.env.development? && false
      @posts = Post.search(params[:search], page: params[:page], per_page: 12)
    else
      @posts = Post
                 .published
                 .uniq
                 .joins('INNER JOIN "categories_posts" ON "posts"."id" = "categories_posts"."post_id"')
                 .where('"categories_posts"."category_id" in (?)', params[:category_ids])
                 .order('"posts"."created_at" DESC')


      @posts = @posts.where('"posts"."body" ILIKE ? OR "posts"."heading" ILIKE ? OR "posts"."short_description" ILIKE ?',
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?

      @posts = @posts.tagged_with(params[:tag_names]) if params[:tag_names].present?

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
    @post.save ? redirect_to(@post) : render(:new)
  end

  def destroy
    destroy! { root_path }
  end

  protected
  def post_params
    params.require(:post).permit(:heading, :short_description, :body, :tag_list, {category_ids: []})
  end
end

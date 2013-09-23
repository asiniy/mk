class PostsController < InheritedResources::Base
  before_filter :only_user!, only: [ :new, :create ]
  before_filter :only_admin!, only: [ :destroy ]
  actions :all, except: [ :edit, :update ]
  respond_to :html

  def index
    params[:category_ids] ||= Category.pluck(:id)

    @posts = Post
      .published
      .uniq
      .joins('INNER JOIN "categories_posts" ON "posts"."id" = "categories_posts"."post_id"')
      .where('"categories_posts"."category_id" in (?)', params[:category_ids])
      .order('"posts"."created_at" DESC')
      .paginate(page: params[:page], per_page: 12)
  end

  def show
    @post = Post.find(params[:id])
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
    params.require(:post).permit(:heading, :short_description, :body, {category_ids: []})
  end
end

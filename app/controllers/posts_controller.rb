class PostsController < InheritedResources::Base
  before_filter :only_user!, only: [ :new, :create ]
  actions :all, except: [ :edit, :update, :destroy ]
  respond_to :html

  def index
    params[:category_ids] ||= Category.pluck(:id)
    @posts = Post.published.joins(:categories_posts).where('"categories_posts"."category_id" in (?)', params[:category_ids])
  end

  def show
    @post = Post.published.find(params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.published = admin_signed_in?
    @post.save ? redirect_to(@post) : render(:new)
  end

  protected
  def post_params
    params.require(:post).permit(:heading, :short_description, :body, {category_ids: []})
  end
end

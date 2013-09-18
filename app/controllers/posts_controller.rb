class PostsController < InheritedResources::Base
  before_filter :only_user!, only: [ :new, :create ]
  actions :all, except: [ :edit, :update, :destroy ]
  respond_to :html

  def create
    @post = current_user.posts.new(post_params)
    @post.save ? redirect_to(@post) : render(:new)
  end

  protected
  def post_params
    params.require(:post).permit(:heading, :short_description, :body)
  end
end

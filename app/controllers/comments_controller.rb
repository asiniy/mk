class CommentsController < InheritedResources::Base
  actions :create
  respond_to :json

  def create
    if user_signed_in?
      @comment = current_user.comments.create(comment_params)
    else
      @comment = Comment.create(comment_params)
    end
  end

  protected
  def comment_params
    params.require(:comment).permit(:author_name, :content, :post_id, :parent_id)
  end
end

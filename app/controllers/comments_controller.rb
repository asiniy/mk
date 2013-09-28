class CommentsController < InheritedResources::Base
  actions :create, :destroy
  before_filter :only_admin!, only: :destroy

  def create
    if user_signed_in?
      @comment = current_user.comments.create(comment_params)
    else
      @comment = Comment.create(comment_params)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.self_and_descendants.delete_all
    render json: { success: true }
  end

  protected
  def comment_params
    params.require(:comment).permit(:author_name, :content, :post_id, :parent_id)
  end
end

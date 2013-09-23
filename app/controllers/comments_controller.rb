class CommentsController < InheritedResources::Base
  actions :create
  respond_to :json

  def create
    if user_signed_in?
      params[:comment][:author_name] = nil
      params[:comment][:user_id] = current_user.id
    end

    @comment = Comment.new(comment_params)
  end

  protected
  def comment_params
    params.require(:comment).permit(:author_name, :content, :post_id, :parent_id)
  end
end

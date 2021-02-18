class CommentsController < ApplicationController
  
  def create
    @memo = Memo.find(params[:memo_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.memo_id = @memo.id
    @comment.save
  end
  
  def destroy
    @memo = Memo.find(params[:memo_id])
    @comment = Comment.find_by(id: params[:id], memo_id: params[:memo_id])
    @comment.destroy
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end

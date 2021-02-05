class MemosController < ApplicationController
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    if @memo.save
      redirect new_user_registration_path
    end
  end
  
  private
  def memo_params
    params.require(:memo).permit(:title,:body)
  end
end

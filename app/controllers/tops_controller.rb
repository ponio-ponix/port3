class TopsController < ApplicationController
  def top
    #@user = User.find(params[:id])
    @memo1 = Memo.last
    @memos = Memo.all
    @user = current_user
  end
end

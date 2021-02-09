class TopsController < ApplicationController
  def top
    #@user = User.find(params[:id])
    @memos = Memo.all
    @user = current_user
  end
end

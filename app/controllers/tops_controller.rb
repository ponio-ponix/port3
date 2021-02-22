class TopsController < ApplicationController
  def top
    @memos = Memo.all.order(id: "DESC") 
    @user = current_user
  end
  
  def about
  end
end

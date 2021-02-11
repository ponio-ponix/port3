class MemosController < ApplicationController
  
  def memo_relation
    @memo = Memo.find(params[:id])
    @memo2 = Memo.find(@memo[:parent_id])
  end
  
  def show
    @memo = Memo.find(params[:id])
    @user = @memo.user
    @memo_parent = Memo.find(@memo[:parent_id])
  end
  
  def edit
  end
  
  def new
    @memo = Memo.new
    @path = Rails.application.routes.recognize_path(request.referer)
    case params[:memo_sort]
    when "0"
       @back_memo = Memo.find(@path[:id])
       @memo.parent_id = @back_memo.id
    when "1"
      @back_memo = nil
    end  
  end
  
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    if @memo.save && @memo.parent_id == nil
      @memo.parent_id = @memo.id
      @memo.save
      redirect_to memo_path(@memo.id)
    else @memo.save
      redirect_to memo_path(@memo.id)
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  def following
  end
  
  private
  def memo_params
    params.require(:memo).permit(:title, :body)
  end
end

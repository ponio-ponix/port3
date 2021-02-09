class MemosController < ApplicationController
  
  def index
  end
  
  def show
    @memo = Memo.find(params[:id])
    @user = @memo.user

  end
  
  def edit
  end
  
  def new
    @memo = Memo.new
    case params[:memo_sort]
    when "0"
      @memo.parent_id = Memo.find(params[:id])
    end  
        
    #@path = Rails.application.routes.recognize_path(request.referer)
    
    #if 
      
    # @path[:controller] == "memos" && @path[:action] == "index"
    # @memo.parent_id = @path.Memo.find(params[:id])
    
    #if @path[:controller] == "memos" && @path[:action] == "show"
    #@memo.parent_id = Memo.where(id: @path[:id])
    #  binding.pry
    
    #end
  
  end
  
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    if @memo.save && @memo.parent_id = nil
      @memo.parent_id = @memo.id
      @memo.save
      redirect_to memo_path(@memo.parent_id)
    else
      @memo.save
      redirect_to memo_path(@memo.parent_id)
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

class MemosController < ApplicationController
  before_action :authenticate_user!
  
  def memo_relation
    @memo = Memo.find(params[:id])
    @memo2 = Memo.find(@memo[:parent_id])#例え
   
   
    @memos = Memo.all
    
    #@repete_boxsが一回目に探したものすべてを表す変数。erbでは<%= repeteboxs.title %>などで使えばよい
     @repete_boxs = Memo.where(parent_id: @memo.id)
     @repete_boxs.each do |repete_box|
       @repete_boxs2 = Memo.where(parent_id: repete_box.id)
     end
       @repete_boxs = @repete_boxs2
    # @repete_boxs2.each do |repete_box2|
    #   @repete_boxs3 = Memo.where(id: repete_box2.parent_id)
    # end
     

    #   @memos.each do |memos|
        
    #     @repeat_boxs do |repeate_boxs|
    #       @repeat_boxs2 = Memo.where(id: )
          
    #   end
    # breke if Memo.where() 
    # end
    
    # loop do
    # @repete_boxs = @memos.where("@memos.id = ?", @memo[:parent_id]
    # @memo = @repete_boxs
    # break if memo.where(memo.id: memo[:parent_id]) == nil
    # end
    
    
    
    
    # @memos.each do |memo|
    #   @memo_repeat = Memo.where(memo.parents_id: params[:id])
      
    # end
    
    
    
    # @memos.each do |memo|
    #   memo.where(memo.id: memo[:parent_id])
    #   break if memo.where(memo.id: memo[:parent_id]) == nil
    # end
  
    


  end
  
  def show
    @memo = Memo.find(params[:id])
    @user = @memo.user
    @memo_parent = Memo.find(@memo[:parent_id])
    #もしshowでcreateをしてしまうなら@memo_new = Memo.new(parent_id: @memo.id, user_id: current_user.id)
  end
  
  def edit
    @memo = Memo.find(params[:id])
    @memo_parent = Memo.find(@memo[:parent_id])
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
    @memo.save
    redirect_to memo_path(@memo.id)
  end
  
  def update
    @memo = Memo.find(params[:id])
    if @memo.user_id != current_user.id
      flash[:notice] = "ログインユーザーのものではありません"
      redirect_to root_path
    end
  end
  
  def destroy
  end
  
  def following
  end
  
  private
  def memo_params
    params.require(:memo).permit(:title, :body, :user_id, :parent_id)
  end
end

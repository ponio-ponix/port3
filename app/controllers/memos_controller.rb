class MemosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]
  
  def index
    @user = User.find(params[:id])
    @memos = Memo.find(@user[:id]).order(id: "DESC") 
  end
  
  def show
    @memo = Memo.find(params[:id])
    @user = @memo.user
    if @memo.parent_id == nil
    else
      @memo_parent = Memo.find(@memo[:parent_id])
    end
    #もしshowでcreateをしてしまうなら@memo_new = Memo.new(parent_id: @memo.id, user_id: current_user.id)
    @comment = Comment.new
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
    if @memo.category_id == nil
      flash[:notice] = "カテゴリーを選択してください"
      render :new and return
    end
    if @memo.save
      flash[:notice] = "投稿しました"
      redirect_to memo_path(@memo.id)
    else
      render :new
      flash[:notice] = "投稿に誤りがあります"
    end  
  end
  
  def following
    @user = User.find(params[:id])
    @users = current_user.following
    @memos = Memo.where(id: @users.ids).order(id: "DESC") 
  end
  
  private
  def memo_params
    params.require(:memo).permit(:title, :body, :user_id, :parent_id, :category_id)
  end
end

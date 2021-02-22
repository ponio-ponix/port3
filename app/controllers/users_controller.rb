class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :search
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではありません"
    redirect_to root_path
    end
    @categories = @user.categories
    @category = Category.new
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではない"
      redirect_to user_path(@user.id)
    end
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(current_user.id)
    else
      render "edit"
    end
    
  end
  
  def quit
    @user = User.find(params[:id])
    if @user == User.guest
      flash[:notice] = "ゲストログインはユーザー情報を編集できません"
      redirect_to user_path
    end
  end

  def out
    @user = current_user
    @user.update(is_deleted: "Invaild")
    reset_session
    flash[:notice] = "退会完了しました"
    redirect_to root_path
  end

  
  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def search
    @q = Memo.ransack(params[:q])
    @results = @q.result
  end
  
  def favorite
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id).all
  end
    
  private
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end  
end

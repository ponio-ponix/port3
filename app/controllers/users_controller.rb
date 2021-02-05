class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    
  end
  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではない"
      redirect to user_path(@user.id)
    end
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(current_user.id)
    else
      render "edit"
    end
    
  end
  
  private
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end  
end

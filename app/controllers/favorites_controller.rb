class FavoritesController < ApplicationController
  
  def index
    @user = User.find(params[:id])
    @favorites = @user.favorites
    @memos = @favorites.memos
    
  end
  
  def create
    @memo = Memo.find(params[:memo_id])
    @favorite = Favorite.new
    @favorite.user_id = current_user.id
    @favorite.memo_id = @memo.id
    @favorite.save
  end
  
  def destroy
    @memo = Memo.find(params[:memo_id])
    @favorite = current_user.favorites.find_by(memo_id: @memo.id)
    @favorite.destroy
  end
  
end

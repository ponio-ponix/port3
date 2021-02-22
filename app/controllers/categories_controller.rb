class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
    flash[:notice] = "ジャンルを登録しました"
    redirect_to request.referer
    else
    @categorys = Category.all
    render :edit
    end
  end
  
  
  def update
    @category = Category.find(params[:id])
    binding.pry
    if @category.update(category_params)
      redirect_to root_path
      flash[:notice] = "ジャンル編集しました"
    else
      render :edit
    end
    
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:category_name, :is_active)
  end
end

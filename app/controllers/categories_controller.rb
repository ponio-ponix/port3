class CategoriesController < ApplicationController
  
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
  
  def destroy
  end
  
  def index
  end
  
  def edit
  end
  
  def category_params
    params.require(:category).permit(:category_name)
  end
end

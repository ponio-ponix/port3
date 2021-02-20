class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
  
  def index
    @memos = Memo.all
  end
  
  def search
    @q = Memo.ransack(params[:q])
    @results = @q.result
  end
  
end

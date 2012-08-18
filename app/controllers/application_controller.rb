class ApplicationController < ActionController::Base
  protect_from_forgery
  
private

  def require_user
    unless current_user
      redirect_to log_out_path
      return false
    end
  end

  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end   
  
end

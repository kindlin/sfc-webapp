class ApplicationController < ActionController::Base
  before_filter :authenticate_member!
  protect_from_forgery
  helper :all

  private

  def require_admin
    unless current_member and current_member.admin
      store_location
      flash[:notice] = "You must be an administrator to access that page"
      redirect_to account_path
      return false
    end
  end

  def store_location
    session[:return_to] = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end
    
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def require_admin
    if user_signed_in? && !current_user.admin?
	    flash[:danger] = "Only admin users can perform that action"
	    redirect_back fallback_location: root_url
	  end
  end
end

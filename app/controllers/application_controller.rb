class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_action :authenticate_user!

	helper_method :boss_admin


	private

  def boss_admin
	  @boss_admin ||= User.find_by(admin: true)
  end
end



# user_signed_in?
# current_user.admin?
# @boss_admin ||= User.find(session[:chef_id]) if session[:chef_id]

# helper_method :boss_admin, :logged_in?
	   #  if !current_user.admin?
		  #   flash[:danger] = "Only admin users can perform that action"
		  #   redirect_to states_path
		  # end

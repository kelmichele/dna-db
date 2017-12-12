class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_action :authenticate_user!

	helper_method :boss_admin


	private

  def boss_admin
	  @boss_admin ||= User.find_by(admin: true)
  end
end

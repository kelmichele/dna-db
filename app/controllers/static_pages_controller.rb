class StaticPagesController < ApplicationController
	before_action :user_cat
	# skip_before_action :authenticate_user!, except: [:chats]

	def chats
		session[:chatrooms] ||= []

    @chatrooms = Chatroom.includes(:recipient, :notes)
                                 .find(session[:chatrooms])

	end

	private
	def user_cat
   	@users = current_or_guest_user.admin? ? User.all.where.not(id: current_or_guest_user) : User.all.where(admin: true)
  end
end

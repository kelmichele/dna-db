class StaticPagesController < ApplicationController
	# skip_before_action :authenticate_user!, except: [:chats]

	def chats
		session[:chatrooms] ||= []

    @chatrooms = Chatroom.includes(:recipient, :notes)
                                 .find(session[:chatrooms])

    if current_or_guest_user.admin?
	    @users = User.all.where.not(id: current_or_guest_user)
	  else
	    @users = User.all.where(admin: true)
    end
	end
end

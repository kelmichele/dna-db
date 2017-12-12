class StaticPagesController < ApplicationController
	skip_before_action :authenticate_user!, except: [:chats]

	def chats
		session[:chatrooms] ||= []

    @users = User.all.where.not(id: current_user)
    @chatrooms = Chatroom.includes(:recipient, :notes)
                                 .find(session[:chatrooms])
	end
end

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

  	def connect
  		# self.current_user = find_current_user
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', "User #{current_user.id}"
  	end

  	def disconnect

  	end

  	protected

  	# def find_current_user
  	# 	if current_user = User.find_by(id: cookies.signed[:user_id])
  	# 	  current_user
  	# 	else
  	# 	  reject_unauthorized_connection
  	# 	end
  	# end

    def find_verified_user
      # (current_user = env['warden'].user) ? current_user : reject_unauthorized_connection
      if current_user = env['warden'].user
        current_user
      else
        reject_unauthorized_connection
      end
    end

  end
end



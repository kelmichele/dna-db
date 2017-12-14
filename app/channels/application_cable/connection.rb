module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_or_guest_user

  	def connect
      self.current_or_guest_user = find_verified_user
      # logger.add_tags 'ActionCable', current_or_guest_user.email
  	end

  	def disconnect
  	end

  	protected

    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end

  end
end



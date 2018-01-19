module ApplicationHelper

	def phone
	  number_to_phone(18667504773, delimiter: ' ', area_code: true,  class: "phone-link")
	  # number_to_phone(8667504773, delimiter: ' ', country_code: 1, area_code: true, pattern: /(\d{1})(\d{3})(\d{4})$/,  class: "phone-link")
	end

	def online_status(user)
	  content_tag :span, user.name,
	              class: "user-#{user.id} online_status #{'online' if user.online?}"
	end

	def admin_online_status(boss_admin)
		if boss_admin.online?
			admin_online_status = 'Online: Chat With Us'
		else
			admin_online_status = 'We are currently offline. Send us a message.'
		end
	  # content_tag :span, boss_admin.boss_title,
	              # class: "admin_online_status #{'online' if boss_admin.online?}"
	end

	def chatrooms_windows
	  params[:controller] != '' ? @chatrooms_windows : []
	end


	def chat_or_account_path
	  if !user_signed_in?
	    'layouts/pre-panel'
	  else
	    'layouts/chatrooms_windows'
	  end
	end

end

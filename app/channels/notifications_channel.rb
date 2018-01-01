class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from("notifications_#{current_or_guest_user.id}_channel")
  end

  def unsubscribed
  end

  def send_message(data)
    conversation = Conversation.find_by(id: data['conversation_id'])
    if conversation && conversation.participates?(current_or_guest_user)
      personal_message = current_or_guest_user.personal_messages.build({body: data['message']})
      personal_message.conversation = conversation
      personal_message.save!
    end
  end
end

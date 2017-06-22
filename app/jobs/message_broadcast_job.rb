class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "channels_#{message.channel.id}_channel",
                                 message: render_message(message)
  end

	def perform_direct(direct_message)
	    sender = direct_message.user
	    recipient = direct_message.conversation.opposed_user(sender)

	    broadcast_to_sender(sender, direct_message)
	    broadcast_to_recipient(recipient, direct_message)
	  end



  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end

  

  private

  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      direct_message: render_directmessage(direct_message, user),
      conversation_id: direct_message.conversation_id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      window: render_window(direct_message.conversation, user),
      direct_message: render_directmessage(direct_message, user),
      conversation_id: direct_message.conversation_id
    )
  end

  def render_directmessage(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { direct_message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end
end

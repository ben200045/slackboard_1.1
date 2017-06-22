class ChannelsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "channels_#{params['channel_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], channel_id: data['channel_id'])
  end
end
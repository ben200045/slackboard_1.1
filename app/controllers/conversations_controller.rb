class ConversationsController < ApplicationController
  def index
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :direct_messages)
                                 .find(session[:conversations])
    end
  end


  def create
    (1..100).each do |a|
      puts "Run: #{a}"
    end
    puts params.to_yaml
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
    puts @conversation.to_yaml
  end

  def conversated?

    session[:conversations].include?(@conversation.id)
  end

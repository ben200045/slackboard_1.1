class ChannelsController < ApplicationController
  def index
    @channel = Channel.order("created_at").last
    @user_groups = Group.joins(:user).where('user_id = ?', current_user.id)
    
    @user_groups.each do |ug|
      @id = ug.id
    end
    
    @group = Group.find(@id)
    @group_channels = Channel.joins(:groups).where('group_id = ?', @group.id)
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = current_user.channels.build(channel_params)
    @user_groups = Group.joins(:user).where('user_id = ?', current_user.id)
    
      if @channel.save
      @user_groups.each do |ug|
        @id = ug.id
      end

      @group = Group.find(@id)
      @channel = Channel.order("created_at").last
      @channel.group_channels.create(group: @group)
      flash[:success] = 'Chat room added!'
      redirect_to channels_path
    else
      render 'new'
    end
  end

  def show
    @channels = Channel.all
    @channel = Channel.includes(:messages).find_by(id: params[:id])
    @message = Message.new

    @user_groups = Group.joins(:user).where('user_id = ?', current_user.id)
    
    @user_groups.each do |ug|
      @id = ug.id
    end

    @group = Group.find(@id)
    @group_channels = Channel.joins(:groups).where('group_id = ?', @group.id)
  end

  private

  def channel_params
    params.require(:channel).permit(:title)
  end

end

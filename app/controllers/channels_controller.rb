class ChannelsController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :show]

  def index
    @group_channels = Channel.joins(:groups).where('group_id = ?', $group.id)
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = current_user.channels.build(channel_params)
   
    #this variable is to vind all instances within the user_group table with the current users id and the current groups id
    @user_groups = UserGroup.joins(:user).where('user_id = ? AND group_id =?', current_user.id, $group.id)

    #Code below is used for extracting the correct group to be saved  to the join table. For some weird reason $group(global variable) has the exact same value using it returns an error
    @array = []
    @user_groups.each do |ug|
      @array  += Group.select('id').where('id = ?', ug.group_id)
    end

    if @channel.save
      @array.each do |a|
        @id = a.id
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
    @group_channels = Channel.joins(:groups).where('group_id = ?', $group.id)
  end

  private

  def channel_params
    params.require(:channel).permit(:title)
  end

  def logged_in_user 
      unless user_signed_in?
        redirect_to root_path
      end
    end

end

class GroupsController < ApplicationController
  def show
    @group = Group.find_by(id: params[:id])
    @group_channels = Channel.joins(:groups).where('group_id = ?', @group)
    
  end

  def index
    @groups = Group.all
    @user_groups = Group.joins(:user).where('user_id = ?', current_user.id)
  end

  def new
    @user = User.find_by(params[:id])
    @group = Group.new
  end

  def create
    @user = User.find_by(params[:id])
    @group= current_user.groups.build(group_params)
    if @group.save
      flash[:success] = 'Group added!'
      redirect_to user_groups_path(current_user.id)
    else
      render 'new'
    end
  end

  private

  def group_params
    params.require(:group).permit(:title, :user_id)
  end
end

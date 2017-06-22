class GroupsController < ApplicationController
  def show
    @group = Group.find_by(id: params[:id])
    @group_channels = Channel.joins(:groups).where('group_id = ?', @group)
    $group = @group
  end

  def index
    #global variable used for adding to the user_group joining table
    $user = User.find_by(id: current_user.id)

    #this variable is to vind all instances within the user_group table with the current users id
    @user_groups = UserGroup.joins(:user).where('user_id = ?', current_user.id)

    #populating title_array with id and title for each group id within the @user_group1 variable, used for populating the group list on the index view
    @title_array = []
    @user_groups.each do |ug|
      @title_array  += Group.select('id, title').where('id = ?', ug.group_id)
    end
    @join = "Join "
    # used for searching for a specific term
    @groups = if params[:term]
      $search = Group.where('title LIKE ?', "%#{params[:term]}%")  
    end
  end

  def join
    if $search != nil
      $search.each do |g|
        $user.user_groups.create(group_id: g.id)
      end
    end

    redirect_to user_groups_path(current_user.id)   
  end

  def new
    @user = User.find_by(params[:id])
    @group = Group.new
  end

  def create
    @user = User.find_by(params[:id])
    @group= current_user.groups.build(group_params)
    if @group.save
      $user.user_groups.create(group_id: @group.id)
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

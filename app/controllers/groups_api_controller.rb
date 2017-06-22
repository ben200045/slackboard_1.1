class GroupsApiController < ApplicationController
  def index
    render json: Group.all
  end
  def show
    render json: Group.find_by(id: params[:id])
  end
end

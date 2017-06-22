class ChannelsApiController < ApplicationController
  def index
    render json: Channel.order("created_at")
  end
  def show
    render json: Channel.find_by(id: params[:id])
  end
end

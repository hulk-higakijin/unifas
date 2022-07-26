class RoomsController < ApplicationController
  def index
    @rooms = current_account.rooms
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.eager_load(:account)
  end
end

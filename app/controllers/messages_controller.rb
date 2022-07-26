class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = current_account.messages.new(message_params)
    @message.room_id = params[:room_id]

    redirect_to @room if @message.save
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end
end

class RoomMessagesController < ApplicationController

  def create
    room                      = Room.find(params[:room_id])
    @room_message             = RoomMessage.new(room_message_params)
    @room_message.user_id     = current_user.id
    @room_message.room_id     = params[:room_id]
    @room_message.save
    redirect_back(fallback_location: rooms_path)
  end

  def destroy
    room                      = Room.find(params[:room_id])
    @room_message             = RoomMessage.find_by(id: params[:id], room_id: params[:room_id])
    @room_message.destroy
    redirect_back(fallback_location: rooms_path)
  end

  private

  def room_message_params
    params.require(:room_message).permit(:message)
  end
end

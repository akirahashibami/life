class RoomsController < ApplicationController

  def set_room
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
    @roomusers = RoomUser.new
  end

  def create
    @room = Room.new(room_params)
      if @room.save
        RoomUser.create(room_id: @room.id, user_id: current_user.id, owner_id: current_user.id)
        redirect_to room_path(@room)
      else
        render :new
      end
  end

  def index
    user = User.find_by(id: current_user.id)
    @rooms = user.room
  end

  def show
    set_room
    @room_menber = @room.user
  end

  def edit
    set_room
    @users = current_user.followings & current_user.followers
  end

  def update
    set_room.update(room_user_params)
    redirect_to room_path(@room)
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_image)
  end

  def room_user_params
    # :user_idsに常に自分のidが入るようにする
    params[:room][:user_ids].push(current_user.id)
    params.require(:room).permit({:user_ids=>[]})
  end

end

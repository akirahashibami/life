class RoomsController < ApplicationController
  def new
    @room = Room.new
    @roomusers = RoomUser.new
  end

  def create
    @room = Room.new(room_params)
    @room.owner_id = current_user.id
    if @room.save
      RoomUser.create(room_id: @room.id, user_id: current_user.id)
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
    @room_menber      = @room.user
    @room_message     = RoomMessage.new
    @room_messages    = @room.room_messages.where(params[:id]).includes(user: :room)
    @room_video       = RoomVideo.new
    @room_videos      = @room.room_videos.where(params[:id]).includes(user: :room)
    mixid_data = @room_messages, @room_videos
    mixid_data.flatten!
    mixid_room_data = mixid_data.sort{|a,b| b.created_at <=> a.created_at}
    @room_data = Kaminari.paginate_array(mixid_room_data).page(params[:page]).per(8)
    # sort{|f,s| f.created_at <=> s.created_at} created_atを新しい順で並べ変える

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

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_name, :room_image)
  end

  def room_user_params
    # :user_idsに常に自分のidが入るようにする
    params[:room][:user_ids].push(current_user.id)
    params.require(:room).permit({ :user_ids => [] })
  end
end

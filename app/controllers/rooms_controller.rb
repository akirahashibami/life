class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def create
    @room     = Room.new(room_params)
      if @room.save
        RoomUser.create(room_id: @room.id, user_id: current_user.id)
        redirect_to room_path(@room)
      else
        render :new
      end
  end

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def authenticate
    room = Room.find(params[:id])

    # ルームが存在しパスワードが合うのであれば、ルームへ
    # さらにルームに入ったことのないユーザーならidを保存
    # さらにセッションでログアウトするまではパスの再入力をいないようにする
    if room && room.authenticate(params[:room][:password])
      login_user = RoomUser.find_by(room_id: room.id, user_id: current_user.id)
      if login_user.nil?
        RoomUser.create(room_id: room.id, user_id: current_user.id)
      end
      session[:user] = current_user.name
      redirect_to room_path(room)
    elsif
      render 'room_signin'
    end
  end

  def room_signin
    @room = Room.find(params[:id])
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_name, :room_image, :password)
  end
end

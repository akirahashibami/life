class RemovePasswordToRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :room_password, :string
  end
end

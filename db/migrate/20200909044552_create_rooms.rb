class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.string :room_image
      t.string :room_password

      t.timestamps
    end
  end
end

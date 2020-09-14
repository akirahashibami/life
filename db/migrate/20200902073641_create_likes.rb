class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :user_id
      t.string :video_id

      t.timestamps
    end
  end
end

class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.string :video
      t.string :title
      t.text :introduction

      t.timestamps
    end
  end
end

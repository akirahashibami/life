class AddColumnVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :conversion_title, :string
  end
end

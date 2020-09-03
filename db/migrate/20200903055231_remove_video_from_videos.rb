class RemoveVideoFromVideos < ActiveRecord::Migration[5.2]
  def change
    remove_column :videos, :video, :string
  end
end

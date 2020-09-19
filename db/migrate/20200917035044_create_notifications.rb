class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer     :visitor_id,  null: false
      t.integer     :visited_id,  null: false
      t.integer     :video_id
      t.integer     :comment_id
      t.string      :action,      null: false,  default: ''
      t.boolean     :checked,     null: false,  default: false

      t.timestamps
    end

      # index
      # 特定のカラムからデータを取得する際に、テーブルの中の
      # 特定のカラムのデータを複製し検索が行いやすいようにしたもの
      add_index :notifications, :visitor_id
      add_index :notifications, :visited_id
      add_index :notifications, :video_id
      add_index :notifications, :comment_id

  end
end

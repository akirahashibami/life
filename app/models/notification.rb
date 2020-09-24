class Notification < ApplicationRecord
  # 作成日時を降順にし、常に新しいデータから順番に取得
  default_scope -> { order(created_at: :desc) }

  # optional: true はnilを許可する
  belongs_to :video,    optional: true
  belongs_to :comment,  optional: true

  belongs_to :visitor,  class_name: 'User',   foreign_key: 'visitor_id',  optional: true
  belongs_to :visited,  class_name: 'User',   foreign_key: 'visited_id',  optional: true
end

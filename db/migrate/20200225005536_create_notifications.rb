class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false # 通知を送ったユーザーのid
      t.integer :visited_id, null: false #  通知を送られたユーザーのid
      t.integer :favorite_id # いいねされた投稿のid
      t.integer :comment_id # 投稿へのコメントのid
      t.string :action, default: '', null: false # 通知の種類（フォロー、いいね、コメント）
      t.boolean :checked, default: false, null: false #通知を送られたユーザーが通知を確認したかどうか

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :favorite_id
    add_index :notifications, :comment_id
  end
end

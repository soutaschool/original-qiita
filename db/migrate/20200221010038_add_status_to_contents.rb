class AddStatusToContents < ActiveRecord::Migration[5.2]
  def change
    add_column :contents, :status, :integer, default: 0, null: false
    # 指定したカラムにからの状態で保存するのを防ぐ null: false
  end
end

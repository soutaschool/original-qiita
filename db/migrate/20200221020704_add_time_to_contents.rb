class AddTimeToContents < ActiveRecord::Migration[5.2]
  def change
    add_column :contents, :time, :datetime
  end
end
# DateTime型 ( = 曜日 + 日付 + 時刻 )

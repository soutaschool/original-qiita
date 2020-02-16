class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :tag
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end

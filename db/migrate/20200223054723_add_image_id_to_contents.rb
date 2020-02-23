class AddImageIdToContents < ActiveRecord::Migration[5.2]
  def change
    add_column :contents, :image_id, :string
  end
end

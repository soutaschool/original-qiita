class AddFavoriteIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :favorite_id, :integer
  end
end

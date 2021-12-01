class AddAlbumStatusToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :album_status, :boolean
  end
end

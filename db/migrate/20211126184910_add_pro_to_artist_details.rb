class AddProToArtistDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :artist_details, :pro, :boolean
  end
end

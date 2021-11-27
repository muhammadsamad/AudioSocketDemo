class CreateArtistDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :artist_details do |t|
      t.string :artist_name
      t.string :email_address
      t.string :country
      t.text :bio
      t.string :social_link, array: true, default: []
      t.string :website_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

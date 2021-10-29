class CreateAuditions < ActiveRecord::Migration[6.1]
  def change
    create_table :auditions do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :artist_name
      t.string :genre, array: true, default: []
      t.string :media
      t.string :media_other
      t.text :info

      t.timestamps
    end
  end
end

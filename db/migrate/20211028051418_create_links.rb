class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :link_field
      t.references :audition, null: false, foreign_key: true

      t.timestamps
    end
  end
end

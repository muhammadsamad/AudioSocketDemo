class AddEmailDescriptionToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :email_description, :text
  end
end

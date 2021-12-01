class AddDetailsToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :status, :integer
    add_column :auditions, :assigned_to, :string
  end
end

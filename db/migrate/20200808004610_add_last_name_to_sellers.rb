class AddLastNameToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :last_name, :string
  end
end

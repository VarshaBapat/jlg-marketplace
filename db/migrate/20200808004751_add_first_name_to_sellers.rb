class AddFirstNameToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :first_name, :string
  end
end

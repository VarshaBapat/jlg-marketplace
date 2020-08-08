class AddBusinessNumberToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :business_number, :string
  end
end

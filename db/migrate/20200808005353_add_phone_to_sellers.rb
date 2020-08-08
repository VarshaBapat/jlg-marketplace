class AddPhoneToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :phone, :string
  end
end

class AddUserIdToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :user_id, :integer
  end
end

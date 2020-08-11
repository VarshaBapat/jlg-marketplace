class RemoveCategoryFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :category, :integer
  end
end

class CreateSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      add_column :first_name, :string
      t.timestamps
    end
  end
end

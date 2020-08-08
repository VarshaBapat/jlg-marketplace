class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :user_id
      t.integer :customer_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end

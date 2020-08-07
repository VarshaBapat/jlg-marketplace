class Product < ApplicationRecord
    belongs_to :seller, foreign_key: "seller_id"
    belongs_to :category, foreign_key: "category_id"
    has_many :reviews
end

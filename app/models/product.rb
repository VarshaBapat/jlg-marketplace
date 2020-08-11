class Product < ApplicationRecord
    belongs_to :seller, foreign_key: "seller_id"
    belongs_to :user, foreign_key: "user_id"
    belongs_to :category
    has_many :reviews
end

class Seller < ApplicationRecord

    has_many :products, class_name: "product", foreign_key: "product_id"
end

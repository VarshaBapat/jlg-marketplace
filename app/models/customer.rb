class Customer < ApplicationRecord
    has_many :comments, class_name: "comment", foreign_key: "comment_id"
    has_many :reviews, class_name: "review", foreign_key: "review_id"

end

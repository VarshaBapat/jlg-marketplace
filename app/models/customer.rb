class Customer < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    # has_many :comments,  foreign_key: "comment_id"
    # has_many :reviews, foreign_key: "review_id"
    has_many :orders, dependent: :delete_all

    validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update

end

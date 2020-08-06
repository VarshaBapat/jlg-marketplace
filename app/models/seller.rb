class Seller < ApplicationRecord

    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    has_many :products, dependent: :delete_all

    validates :first_name, presence: true, on: :update
    validates :last_name, presence: true, on: :update
end

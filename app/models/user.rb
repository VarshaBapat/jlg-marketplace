class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: {customer: 0, seller: 1, admin: 2}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  
  has_one :customer, dependent: :destroy
  has_one :seller, dependent: :destroy
  has_one :admin, dependent: :destroy  
  
  validates :role, presence: true

  private
end

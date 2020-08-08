class Seller < ApplicationRecord

    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    has_many :products, dependent: :delete_all

    validates :first_name, presence: true, on: :update
    validates :last_name, presence: true, on: :update

      def phone_number
    if phone != nil || phone != ""
      phone.to_s.delete('^0-9')
      if phone.empty?
        errors.add(:phone, "can't be blank")
      elsif phone.length != 10
        errors.add(:phone, "must be a 10 digit mobile number. eg. '0411222333'")
      elsif phone[0..1] != "04"
        errors.add(:phone, "must be a mobile number starting with '04'")
      end
    end
  end

  
end

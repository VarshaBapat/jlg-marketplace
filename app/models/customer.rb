class Customer < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    # has_many :comments,  foreign_key: "comment_id"
    has_many :reviews, foreign_key: "review_id"

    validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :address, presence: true, on: :update
  validate :phone_number, on: :update

  private

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
  
  def customer_dob
    current_date = Date.today

    dob_year = dob.split('-')[0].to_i
    dob_month = dob.split('-')[1].to_i
    dob_day = dob.split('-')[2].to_i

    if current_date.year - 16 < dob_year
      errors.add(:customer, "must be over 16 to sign up")
    elsif current_date.year - 16 == dob_year and current_date.month < dob_month
      errors.add(:customer, "must be over 16 to sign up")
    elsif current_date.year - 16 == dob_year and current_date.month == dob_month and current_date.day < dob_day
      errors.add(:customer, "must be over 16 to sign up")
    end
  end

end

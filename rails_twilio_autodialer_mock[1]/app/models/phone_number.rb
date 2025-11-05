# app/models/phone_number.rb
class PhoneNumber < ApplicationRecord
  validates :number, presence: true
end

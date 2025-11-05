# db/seeds.rb
require 'csv'
CSV.foreach(Rails.root.join('db','phone_numbers.csv'), headers: true) do |row|
  PhoneNumber.create(number: row['number'], status: 'queued')
end

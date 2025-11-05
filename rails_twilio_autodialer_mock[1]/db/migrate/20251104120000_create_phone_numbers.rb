# db/migrate/20251104120000_create_phone_numbers.rb
class CreatePhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.string :status
      t.text :notes
      t.timestamps
    end
  end
end

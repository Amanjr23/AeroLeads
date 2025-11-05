# app/controllers/phone_numbers_controller.rb
class PhoneNumbersController < ApplicationController
  def new
  end

  def create
    # In a real app we'd enqueue jobs. Here we simulate the Twilio mock processing.
    CsvPath = Rails.root.join('db', 'phone_numbers.csv')
    @results = []
    if File.exist?(CsvPath)
      CSV.foreach(CsvPath, headers: true) do |row|
        number = row['number']
        # Twilio mock call (simulated)
        res = TwilioMockService.call(number)
        @results << { number: number, status: res[:status], notes: res[:notes] }
      end
    end

    # Save the static output file for convenience
    out_path = Rails.root.join('db','output.csv')
    CSV.open(out_path, 'w') do |csv|
      csv << ['number','status','notes']
      @results.each do |r|
        csv << [r[:number], r[:status], r[:notes]]
      end
    end

    render 'index'
  end

  def index
    @phone_numbers = PhoneNumber.order(created_at: :desc).limit(500)
  end
end

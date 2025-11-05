# app/services/twilio_mock_service.rb
class TwilioMockService
  # Simulates a Twilio call response: always returns completed for demo
  def self.call(number)
    # You can add randomization if needed; kept deterministic here.
    { status: 'Completed', notes: 'Mock call succeeded' }
  end
end

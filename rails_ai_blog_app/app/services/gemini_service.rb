# app/services/gemini_service.rb
require 'httparty'
class GeminiService
  API_URL = 'https://api.generativelanguage.googleapis.com/v1beta/models/gemini-1.5-mini:generate' # example; update as needed

  def initialize(api_key)
    @api_key = api_key
  end

  # prompt -> returns text
  def generate(prompt)
    return mock_response(prompt) unless @api_key.present?
    headers = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@api_key}" }
    body = { prompt: prompt, max_tokens: 800 }.to_json
    resp = HTTParty.post(API_URL, body: body, headers: headers)
    if resp.code == 200
      # This is a placeholder parser; adapt to real Gemini response shape
      JSON.parse(resp.body)['candidates'][0]['content'][0]['text'] rescue resp.body.to_s
    else
      nil
    end
  rescue => e
    nil
  end

  private

  def mock_response(prompt)
    "This is a mocked AI-generated article for prompt: #{prompt[0..120]}...\n\n(Replace with real Gemini API key to generate live content.)"
  end
end

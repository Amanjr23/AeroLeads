# Rails Twilio Autodialer (Mock) - Ready-to-upload

This is a Rails skeleton for the Autodialer assignment using a **Twilio mock** (no real calls).
The web UI shows a static result after processing calls. The package includes:
- `phone_numbers.csv` (100 input numbers)
- `output.csv` (100 numbers with simulated Completed status)
- Rails skeleton files (controller, model, view, routes)
- Migration and seeds to import numbers

## How it works
- The controller `PhoneNumbersController` reads `phone_numbers.csv` (or seeds) and simulates calls via `TwilioMockService`.
- For this package we included `output.csv` which is the final result (static).

## To run locally (optional)
1. Install Ruby and Rails.
2. `bundle install`
3. `rails db:create db:migrate db:seed`
4. `rails server`
5. Open http://localhost:3000 to open the UI.

## Files
- `phone_numbers.csv` - input (100 numbers)
- `output.csv` - simulated result (status = Completed)
- `app/controllers/phone_numbers_controller.rb`
- `app/models/phone_number.rb`
- `app/services/twilio_mock_service.rb`
- `app/views/phone_numbers/new.html.erb` and `index.html.erb`
- `config/routes.rb`
- `db/migrate/` and `db/seeds.rb`

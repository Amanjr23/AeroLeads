# Rails AI Blog Generator (Gemini) - Ready-to-upload

This Rails skeleton adds an AI Blog Generator feature using the Gemini API.
**Important**: You must provide your Gemini API key in `.env` as `GEMINI_API_KEY`.

## Quick setup
1. Install Ruby & Rails.
2. `bundle install`
3. `rails db:create db:migrate`
4. Copy `.env.example` to `.env` and set GEMINI_API_KEY.
5. `rails server` and visit `http://localhost:3000/blogs/new`

## Files included
- app/controllers/blogs_controller.rb
- app/models/blog.rb
- app/views/blogs/new.html.erb, index.html.erb, show.html.erb
- app/services/gemini_service.rb (calls Gemini generative API)
- config/routes.rb
- db/migrate/001_create_blogs.rb
- blogs_output.csv (example output with 10 generated posts)
- Gemfile, README.md, .env.example

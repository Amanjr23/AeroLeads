# app/controllers/blogs_controller.rb
require 'csv'
class BlogsController < ApplicationController
  def index
    @blogs = Blog.order(created_at: :desc).all
  end

  def new
  end

  def create
    titles = params[:titles].to_s.split("\n").map(&:strip).reject(&:blank?)
    service = GeminiService.new(ENV['GEMINI_API_KEY'])
    created = []
    titles.each do |line|
      title, details = line.split(' - ', 2)
      prompt = "Write a technical blog article about: \"#{title.strip}\". Details: \#{details.to_s}\nInclude code examples and conclusion."
      content = service.generate(prompt)
      b = Blog.create(title: title.strip, content: content || 'Error generating content')
      created << b
    end

    # also write CSV output for convenience
    CSV.open(Rails.root.join('blogs_output.csv'), 'w') do |csv|
      csv << ['id','title','content','created_at']
      Blog.order(created_at: :desc).limit(created.size).each do |bk|
        csv << [bk.id, bk.title, bk.content.gsub(/\r?\n/, ' '), bk.created_at]
      end
    end

    redirect_to blogs_path, notice: "Generated #{created.size} blogs."
  end

  def show
    @blog = Blog.find(params[:id])
  end
end

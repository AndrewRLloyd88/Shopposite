class Admin::DashboardController < ApplicationController

  # adding basic http authentication for admins
  http_basic_authenticate_with name: ENV['HTTP_BASIC_USER'],
  password: ENV['HTTP_BASIC_PASSWORD'],
  if: -> { ENV['HTTP_BASIC_PASSWORD'].present? }

  def show
  # controller fetches data, makes it available to the views automagically
  @product_names = Product.all.map do |product|
    product[:name]
  end
  @category_names = Category.all.map do |category|
    category[:name]
  end
  @product_count = Product.count
  @category_count = Category.count
  end
end

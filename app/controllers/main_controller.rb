# Controller for the main index page
class MainController < ApplicationController
  helper LocationHourHelper
  def index
    @date = Date.today.to_formatted_s(:rfc822).upcase

    client = Weatherman::Client.new unit: 'F'
    response = client.lookup_by_woeid 2459115
    @temperature = response.condition['temp'] unless response.nil?

    @locations = Location.where(current: true).order(:locale)

    @articles = Article.where(is_active: true).order(published_at: :desc).last(9)
  end
end

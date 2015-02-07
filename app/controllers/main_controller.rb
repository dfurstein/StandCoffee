# Controller for the main index page
class MainController < ApplicationController
  def index
    @date = Date.today.to_formatted_s(:rfc822)

    client = YahooWeather::Client.new
    response = client.fetch_by_location('New York')
    @temperature = response.condition.temp unless response.nil?

    @locations = Location.where(current: true)
  end
end

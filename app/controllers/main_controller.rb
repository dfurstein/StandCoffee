# Controller for the main index page
class MainController < ApplicationController
  def index
    @date = Date.today.to_formatted_s(:rfc822).upcase

    client = Weatherman::Client.new unit: 'F'
    response = client.lookup_by_woeid 2459115
    @temperature = response.condition['temp']

    @locations = Location.where(current: true)
  end
end

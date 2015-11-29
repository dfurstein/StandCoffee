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

    @map_locations = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.picture(
        'url' => 'assets/favicon.ico',
        'width' => 48,
        'height' => 48
      )
      marker.infowindow "<strong>#{location.locale}</strong><br />#{location.address}"
    end
  end
end

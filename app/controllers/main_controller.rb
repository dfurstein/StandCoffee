# Controller for the main index page
class MainController < ApplicationController
  helper LocationHourHelper
  def index
    @date = Date.today.to_formatted_s(:rfc822).upcase

    client = Weatherman::Client.new unit: 'F'
    response = begin client.lookup_by_woeid 2459115 rescue nil end
    @temperature = response.condition['temp'] unless response.nil?

    @current_locations = Location.where(current: true).where('live_on <= ?', Date.today).order(:locale)
    @future_locations = Location.where(current: true).where('live_on > ?', Date.today).order(:locale)
    @local_locations = @current_locations.where(state: ['NY', 'NJ', 'CT'])

    @articles = Article.where(is_active: true).order(published_at: :desc).last(9)

    @map_locations = Gmaps4rails.build_markers(@local_locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.picture(
        'url' => '/assets/favicon-19585d46424de7148c82d6c044b3356c.ico',
        'width' => 48,
        'height' => 48
      )
      marker.infowindow "<strong>#{location.locale}</strong><br />#{location.address}"
    end
  end
end

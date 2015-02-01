class LocationHour < ActiveRecord::Base
  attr_accessible :location_id, :day_of_week, :open, :close

  def self.add_hours(location_id, day_of_week, open, close)
    hours = LocationHour.new

    hours.location_id = location_id
    hours.day_of_week = day_of_week
    hours.open = open
    hours.close = close

    hours.save
  end
end

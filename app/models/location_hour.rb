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

  def self.hours(location_id)
    where(location_id: location_id).group([:open, :close]).each_with_object({}) do |hours, hash|
      hash[[hours.open, hours.close]] = where(location_id: location_id, open: hours.open, close: hours.close).pluck(:day_of_week)
    end.invert
  end
end

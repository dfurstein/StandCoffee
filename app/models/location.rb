class Location < ActiveRecord::Base
  attr_accessible :current, :neighborhood, :street, :city, :state,
                  :zipcode, :locale, :latitude, :longitude

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? && (obj.street_changed? || obj.city_changed?) }

  def self.add_location(neighborhood, street, city, state, zipcode, locale)
    location = Location.new

    location.neighborhood = neighborhood
    location.street = street
    location.city = city
    location.state = state
    location.zipcode = zipcode
    location.locale = locale

    location.save
  end

  def self.activate(id)
    location = find(id)

    location.current = true

    location.save
  end

  def self.deactivate(id)
    location = find(id)

    location.current = false

    location.save
  end

  def address
    [street, city, state].compact.join(', ') + ' ' + zipcode.to_s
  end
end

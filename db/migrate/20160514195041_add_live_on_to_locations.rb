class AddLiveOnToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :live_on, :date
  end
end

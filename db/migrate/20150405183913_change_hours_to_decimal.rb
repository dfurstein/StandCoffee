class ChangeHoursToDecimal < ActiveRecord::Migration
  def change
    change_column :location_hours, :open, :decimal
    change_column :location_hours, :close, :decimal
  end
end

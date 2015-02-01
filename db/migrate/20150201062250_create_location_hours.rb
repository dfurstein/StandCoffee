class CreateLocationHours < ActiveRecord::Migration
  def change
    create_table :location_hours do |t|
      t.integer :location_id, null: false
      t.integer :day_of_week, null: false
      t.integer :open, null: false
      t.integer :close, null: false

      t.timestamps
    end
  end
end

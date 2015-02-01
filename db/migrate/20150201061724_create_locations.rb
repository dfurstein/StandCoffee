class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.boolean :current, default: false, null: false
      t.string :neighborhood, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :zipcode, null: false
      t.string :locale

      t.timestamps
    end
  end
end

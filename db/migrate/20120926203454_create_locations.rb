class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :lon
      t.decimal :lat
      t.string :name

      t.timestamps
    end
  end
end

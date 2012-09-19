class CreateQuantileSettings < ActiveRecord::Migration
  def change
    create_table :quantile_settings do |t|
      t.integer :historial_start
      t.integer :historical_end
      t.integer :predicted_start
      t.integer :predicted_end
      t.integer :period_id
      t.integer :algorithm, default: 0

      t.timestamps
    end
  end
end

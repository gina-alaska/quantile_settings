class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :low_temp_threshold
      t.integer :high_temp_threshold
      t.string :column1
      t.string :column2
      t.string :status, default: 'new'
      t.integer :quantile_setting_id

      t.timestamps
    end
  end
end

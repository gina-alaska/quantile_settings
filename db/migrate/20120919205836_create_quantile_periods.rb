class CreateQuantilePeriods < ActiveRecord::Migration
  def change
    create_table :quantile_periods do |t|
      t.string :name

      t.timestamps
    end
  end
end

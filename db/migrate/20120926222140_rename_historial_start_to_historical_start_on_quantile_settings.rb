class RenameHistorialStartToHistoricalStartOnQuantileSettings < ActiveRecord::Migration
  def change
    rename_column :quantile_settings, :historial_start, :historical_start
  end
end

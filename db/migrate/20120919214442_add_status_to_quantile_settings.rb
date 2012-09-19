class AddStatusToQuantileSettings < ActiveRecord::Migration
  def change
    add_column :quantile_settings, :status, :string, default: 'Queued'
  end
end

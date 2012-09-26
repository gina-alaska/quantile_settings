class AddLocationIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :location_id, :integer
  end
end

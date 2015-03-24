class AddTimelineIdToBank < ActiveRecord::Migration
  def change
    add_column :banks, :timeline_id, :integer
  end
end

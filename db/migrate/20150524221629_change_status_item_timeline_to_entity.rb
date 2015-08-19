class ChangeStatusItemTimelineToEntity < ActiveRecord::Migration
  def change
    remove_column :item_timelines, :status
    add_column :item_timelines, :status_item_id, :integer
  end
end

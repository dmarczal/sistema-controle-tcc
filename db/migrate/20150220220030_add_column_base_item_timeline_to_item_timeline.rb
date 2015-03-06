class AddColumnBaseItemTimelineToItemTimeline < ActiveRecord::Migration
  def change
    add_column :item_timelines, :item_base_timeline_id, :integer
  end
end

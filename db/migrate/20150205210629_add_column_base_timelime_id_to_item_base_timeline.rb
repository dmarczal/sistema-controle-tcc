class AddColumnBaseTimelimeIdToItemBaseTimeline < ActiveRecord::Migration
  def change
    add_column :item_base_timelines, :base_timeline_id, :integer
  end
end

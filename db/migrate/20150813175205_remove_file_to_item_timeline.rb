class RemoveFileToItemTimeline < ActiveRecord::Migration
  def change
    remove_column :item_timelines, :file
  end
end

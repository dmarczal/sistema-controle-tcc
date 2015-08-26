class AddColumnNoteToItemTimeline < ActiveRecord::Migration
  def change
    add_column :item_timelines, :note, :text
  end
end

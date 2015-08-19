class AddDropboxFileToItemTimeline < ActiveRecord::Migration
  def change
    add_column :item_timelines, :dropbox_file, :string
  end
end

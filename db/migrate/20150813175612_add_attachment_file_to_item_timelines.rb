class AddAttachmentFileToItemTimelines < ActiveRecord::Migration
  def self.up
    change_table :item_timelines do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :item_timelines, :file
  end
end

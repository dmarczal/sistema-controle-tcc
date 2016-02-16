class AddAttachmentComplementaryFileToApprovals < ActiveRecord::Migration

  def self.up
    change_table :approvals do |t|
      t.attachment :complementary_file
    end
  end

  def self.down
    remove_attachment :approvals, :complementary_file
  end
end

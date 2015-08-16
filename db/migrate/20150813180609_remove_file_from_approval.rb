class RemoveFileFromApproval < ActiveRecord::Migration
  def self.up
    change_table :approvals do |t|
      t.remove :file
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :approvals, :file
  end
end

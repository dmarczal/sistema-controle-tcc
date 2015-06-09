class ChangeForeignKeyApproval < ActiveRecord::Migration
  def change
    remove_column :approvals, :timeline_id
    add_column :approvals, :bank_id, :integer
  end
end

class AddDropboxFileToApprovals < ActiveRecord::Migration
  def change
    add_column :approvals, :dropbox_file, :string
  end
end

class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :timeline_id
      t.integer :type_approval_id
      t.string :file

      t.timestamps null: false
    end
  end
end

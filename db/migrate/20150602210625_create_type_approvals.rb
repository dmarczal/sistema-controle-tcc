class CreateTypeApprovals < ActiveRecord::Migration
  def change
    create_table :type_approvals do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

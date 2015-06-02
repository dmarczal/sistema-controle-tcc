class CreateBankStatuses < ActiveRecord::Migration
  def change
    create_table :bank_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
    remove_column :banks, :bank_statuses_id
    add_column :banks, :bank_status_id, :integer
  end
end

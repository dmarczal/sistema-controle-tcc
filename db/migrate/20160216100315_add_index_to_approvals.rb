class AddIndexToApprovals < ActiveRecord::Migration
  def change
    add_index :banks, :_type, :name => 'banks_type_idx'
    add_index :banks, :date, :name => 'banks_date_idx'
  end
end

class ChangeColumnDateToDatetimeInBanks < ActiveRecord::Migration
  def up
    change_column :banks, :date, :datetime
  end

  def down
    change_column :banks, :date, :date
  end
end

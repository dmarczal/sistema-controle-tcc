class AddBankIdToTimeline < ActiveRecord::Migration
  def change
    add_column :timelines, :bank_id, :integer
  end
end

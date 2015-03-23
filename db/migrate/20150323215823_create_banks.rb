class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.date :date
      t.float :note

      t.timestamps null: false
    end
  end
end

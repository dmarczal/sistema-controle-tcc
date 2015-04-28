class CreateBankNotes < ActiveRecord::Migration
  def change
    create_table :bank_notes do |t|
      t.integer :bank_id
      t.integer :teacher_id
      t.float :note

      t.timestamps null: false
    end
  end
end

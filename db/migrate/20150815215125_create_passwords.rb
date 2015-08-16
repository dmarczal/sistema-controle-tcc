class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :password
      t.references :teacher, index: true
      t.references :student, index: true

      t.timestamps null: false
    end
    add_foreign_key :passwords, :teachers
    add_foreign_key :passwords, :students
  end
end

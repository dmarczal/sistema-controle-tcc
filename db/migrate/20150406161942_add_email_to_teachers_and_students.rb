class AddEmailToTeachersAndStudents < ActiveRecord::Migration
  def change
    add_column :students, :email, :string
    add_column :teachers, :email, :string
  end
end

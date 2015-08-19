class AddLoginIntoStudentModelAndTeacherModel < ActiveRecord::Migration
  def change
    add_column :students, :login, :string
    add_column :teachers, :login, :string
    add_column :teachers, :role_id, :integer
  end
end

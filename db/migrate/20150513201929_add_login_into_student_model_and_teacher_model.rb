class AddLoginIntoStudentModelAndTeacherModel < ActiveRecord::Migration
  def change
    drop_table if_exists: true, :logins
    add_column :students, :login, :string
    add_column :teachers, :login, :string
    add_column :teachers, :role_id, :integer
  end
end

class AddLoginIntoStudentModelAndTeacherModel < ActiveRecord::Migration
  def change
    drop_table :logins, if_exists: true
    add_column :students, :login, :string
    add_column :teachers, :login, :string
    add_column :teachers, :role_id, :integer
  end
end

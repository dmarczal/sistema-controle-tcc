class RemoveAccessColumnFromTeacher < ActiveRecord::Migration
  def change
    remove_column :teachers, :access
  end
end

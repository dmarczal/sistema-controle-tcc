class AddColumnAvaliableToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :avaliable, :boolean
  end
end

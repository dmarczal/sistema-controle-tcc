class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :access
      t.string :lattes
      t.string :atuacao

      t.timestamps null: false
    end
  end
end

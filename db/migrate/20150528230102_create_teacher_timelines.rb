class CreateTeacherTimelines < ActiveRecord::Migration
  def change
    create_table :teacher_timelines do |t|
      t.integer :teacher_id
      t.integer :timeline_id

      t.timestamps null: false
    end
    add_index :teacher_timelines, :teacher_id, :name => 'teacher_timelines_teacher_id_idx'
    add_index :teacher_timelines, :timeline_id, :name => 'teacher_timelines_timeline_id_idx'
  end
end

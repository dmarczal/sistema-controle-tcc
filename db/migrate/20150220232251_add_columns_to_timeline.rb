class AddColumnsToTimeline < ActiveRecord::Migration
  def change
    add_column :timelines, :student_id, :integer
    add_column :timelines, :teacher_id, :integer
    add_column :timelines, :base_timeline_id, :integer
    add_column :item_timelines, :timeline_id, :integer
  end
end

class AddIndexForTables < ActiveRecord::Migration
  def change
    add_index :banks, :timeline_id, :name => 'banks_timeline_idx'
    add_index :banks_teachers, :bank_id, :name => 'banks_teachers_bank_id_idx'
    add_index :banks_teachers, :teacher_id, :name => 'banks_teachers_teacher_id_idx'
    add_index :item_base_timelines, :base_timeline_id, :name => 'item_base_timelines_base_timeline_id_idx'
    add_index :item_timelines, :item_base_timeline_id, :name => 'item_timelines_item_base_timeline_id_idx'
    add_index :item_timelines, :timeline_id, :name => 'item_timelines_timeline_id_idx'
    add_index :orientations, :timeline_id, :name => 'orientations_timeline_id_idx'
    add_index :teachers, :role_id, :name => 'teachers_role_id_idx'
    add_index :timelines, :base_timeline_id, :name => 'timelines_base_timeline_id_idx'
  end
end

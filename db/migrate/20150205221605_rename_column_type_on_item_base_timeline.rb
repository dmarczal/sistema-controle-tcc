class RenameColumnTypeOnItemBaseTimeline < ActiveRecord::Migration
  def change
    rename_column :item_base_timelines, :type, :_type
  end
end

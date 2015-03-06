class CreateItemBaseTimelines < ActiveRecord::Migration
  def change
    create_table :item_base_timelines do |t|
      t.string :description, :limit => 500
      t.string :title, :limit => 50
      t.string :type, :limit => 20
      t.date :date
      t.string :link

      t.timestamps null: false
    end
  end
end

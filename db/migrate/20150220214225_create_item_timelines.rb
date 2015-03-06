class CreateItemTimelines < ActiveRecord::Migration
  def change
    create_table :item_timelines do |t|
      t.string :status
      t.string :file

      t.timestamps null: false
    end
  end
end

class CreateBaseTimelines < ActiveRecord::Migration
  def change
    create_table :base_timelines do |t|
      t.integer :year, :limit => 4
      t.string :half, :limit => 1
      t.string :tcc, :limit => 1
      t.string :json

      t.timestamps null: false
    end
  end
end

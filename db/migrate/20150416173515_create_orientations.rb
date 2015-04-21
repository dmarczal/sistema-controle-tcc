class CreateOrientations < ActiveRecord::Migration
  def change
    create_table :orientations do |t|
      t.string :title
      t.date :date
      t.text :description
      t.integer :timeline_id

      t.timestamps null: false
    end
  end
end

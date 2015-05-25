class CreateStatusItems < ActiveRecord::Migration
  def change
    create_table :status_items do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.string :slug
      t.text :body

      t.timestamps null: false
    end
    add_index :notices, :slug, unique: true
  end
end

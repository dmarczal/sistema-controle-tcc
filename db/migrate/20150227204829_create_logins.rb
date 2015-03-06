class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :login
      t.string :password
      t.integer :access
      t.integer :entity_id

      t.timestamps null: false
    end
  end
end

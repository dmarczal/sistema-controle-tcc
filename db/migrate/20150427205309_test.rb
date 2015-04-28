class Test < ActiveRecord::Migration
  def self.up
    drop_table :banks_teachers, :if_exists => true
    create_table :banks_teachers, :id => false do |t|
      t.integer :bank_id
      t.integer :teacher_id
    end

    add_index :banks_teachers, [:bank_id, :teacher_id]
  end

  def self.down
    drop_table :categories_users
  end
end

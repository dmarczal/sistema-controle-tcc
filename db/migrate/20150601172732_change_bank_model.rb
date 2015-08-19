class ChangeBankModel < ActiveRecord::Migration
  def change
    remove_column :banks, :note
    add_column :banks, :file, :string
    add_column :banks, :_type, :string
  end
end

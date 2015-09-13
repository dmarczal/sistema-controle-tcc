class AddColumnAcceptToOrientation < ActiveRecord::Migration
  def change
    add_column :orientations, :accept, :boolean, default: :false
  end
end

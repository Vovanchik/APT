class AddColumnAssignedBy < ActiveRecord::Migration
  def self.up
    add_column :jobs, :assigned_by_id, :integer
  end

  def self.down
    remove_column :jobs, :assigned_by_id
  end
end

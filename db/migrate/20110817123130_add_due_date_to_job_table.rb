class AddDueDateToJobTable < ActiveRecord::Migration
  def self.up
    add_column :jobs, :due_date, :date
    add_column :jobs, :due_time, :time
  end

  def self.down
    remove_column :jobs, :due_date, :date
    remove_column :jobs, :due_time, :time
  end
end

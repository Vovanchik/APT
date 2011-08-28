class ChangeDefaultValueOfStatus < ActiveRecord::Migration
  def self.up
    change_column :jobs, :status, :string, :default => "open"
    change_column :jobs, :description, :text
    Job.update_all ["status = ?", "open"], ["status = ?", "not_started"]
  end

  def self.down
  end
end

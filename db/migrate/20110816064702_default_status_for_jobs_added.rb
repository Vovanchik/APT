class DefaultStatusForJobsAdded < ActiveRecord::Migration
  def self.up
    change_column_default :jobs, :status, 'not_started'
  end

  def self.down
  end
end

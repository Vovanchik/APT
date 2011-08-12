class JobsHandlers < ActiveRecord::Migration
  def self.up
    create_table :jobs_handlers, :id => false do |t|
      t.integer :job_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :jobs_handlers
  end
end

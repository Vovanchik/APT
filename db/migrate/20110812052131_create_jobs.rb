class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :author_id
      t.integer :forum_id
      t.integer :job_number
      t.string :description
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end

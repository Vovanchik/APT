class CreateConclusions < ActiveRecord::Migration
  def self.up
    create_table :conclusions do |t|
      t.integer :job_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :conclusions
  end
end

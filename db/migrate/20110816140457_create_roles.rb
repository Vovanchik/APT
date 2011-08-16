class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_column :users, :role_id, :integer
  end

  def self.down
    drop_table :roles
    remove_column :users, :role_id
  end
end

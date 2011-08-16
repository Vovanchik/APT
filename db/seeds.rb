# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.create(:name => 'super_user', :description => 'This is super user')
Role.create(:name => 'user', :description => 'Should be added')
Role.create(:name => 'moderator', :description => 'Should be added')
Role.create(:name => 'guest', :description => 'Should be added')
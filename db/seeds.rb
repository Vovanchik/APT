# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

role_super_user = Role.create(:name => 'super_user', :description => 'This is super user')
Role.create(:name => 'user', :description => 'Can CRU Jobs')
#Role.create(:name => 'developer', :description => 'Can resolve bugs')
#Role.create(:name => 'moderator', :description => 'Should be added')
#Role.create(:name => 'guest', :description => 'Should be added')

admin_user = User.create(:id =>1, :nick=> 'admin',
            :password => 'admin',
            :password_confirmation => 'admin',
            :email => 'admin@example.com',
            :role => role_super_user)

forum_free = Forum.create(:name => 'Free', :author_id =>1)
forum_private = Forum.create(:name => 'Private', :author_id => 1)
apt_bugs_ = Forum.create(:name => 'APT_BUGS', :author_id => 1)
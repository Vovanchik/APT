class User < ActiveRecord::Base
  has_and_belongs_to_many :forums
  has_and_belongs_to_many :jobs,
    :class_name => "Job",
    :join_table => "jobs_handlers",
    :uniq => true

end

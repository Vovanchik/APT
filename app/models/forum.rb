class Forum < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :jobs

  belongs_to :author,
    :class_name => "User",
    :foreign_key => "author_id"

  validates :name, :presence => { :message => "should be specified"}

  def free?
    self.name == 'Free'
  end

  def private?
    self.name == 'Private'
  end

end

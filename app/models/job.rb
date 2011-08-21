class Job < ActiveRecord::Base
  has_and_belongs_to_many :handlers,
    :class_name => "User",
    :join_table => "jobs_handlers",
    :uniq => true
  
  belongs_to :forum

  belongs_to :author,
    :class_name => "User",
    :foreign_key => "author_id"

  belongs_to :assigned_by,
    :class_name => "User",
    :foreign_key => "assigned_by_id"

  has_many :conclusions

  default_scope :order => 'created_at DESC'

  validates :description, :presence => { :message => "should be specified"}

  def sort_conclusions_by_desc
    conclusions.sort{ |a,b| b.created_at <=> a.created_at }
  end

  def show_last_conclusion
    conclusions.last(:all, :order => :created_at)
  end
end

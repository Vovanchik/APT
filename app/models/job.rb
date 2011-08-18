class Job < ActiveRecord::Base
  validates_acceptance_of :description, :message => "should be specified"


  has_and_belongs_to_many :handlers,
    :class_name => "User",
    :join_table => "jobs_handlers",
    :uniq => true
  
  belongs_to :forum
  belongs_to :author,
    :class_name => "User",
    :foreign_key => "author_id"

  has_many :conclusions

  def sort_conclusions_by_desc
    conclusions.sort{ |a,b| b.created_at <=> a.created_at }
  end

  def show_last_conclusion
    conclusions.last(:all, :order => :created_at)
  end

end

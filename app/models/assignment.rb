class Assignment < ActiveRecord::Base

  attr_accessible :assn, 
                  :instructions, 
                  :student_id,
                  :active, 
                  :mlunch, :tlunch, :wlunch, :rlunch, :flunch, 
                  :mafter, :tafter, :wafter, :rafter, :fafter
  belongs_to :user
  belongs_to :student
  
  validates :assn, :presence => true
  validates :student_id, :presence => true
  
  default_scope :order => 'assignments.created_at DESC'
end

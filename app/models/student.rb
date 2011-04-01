class Student < ActiveRecord::Base
  attr_accessible :name, :assignment, :instructions, :mlunch, :tlunch, :wlunch, :rlunch, :flunch, :mafter, :tafter, :wafter, :rafter, :fafter
  belongs_to :user
  
  validates :name, :presence => true
  validates :assignment, :presence => true
    
  default_scope :order => 'students.created_at DESC'
end

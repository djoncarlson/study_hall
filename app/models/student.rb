class Student < ActiveRecord::Base
  attr_accessible :name, :assignment, :instructions

  belongs_to :user
  
  validates :name, :presence => true
  validates :assignment, :presence => true
    
  default_scope :order => 'students.created_at DESC'
end

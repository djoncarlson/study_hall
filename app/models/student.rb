class Student < ActiveRecord::Base
  attr_accessible :name, :instructions, :grade
  has_many :assignments, :dependent => :destroy
  
  validates :name, :presence => true
  validates :grade, :presence => true
    
  default_scope :order => 'students.grade, students.name'
  
  def self.search(search)
    if(search)
      where('upper(name) LIKE upper(?)', "%#{search}%")
    else
      scoped
    end
  end
end

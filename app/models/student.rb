class Student < ActiveRecord::Base
  attr_accessible :name, :instructions
  has_many :assignments
  
  validates :name, :presence => true
    
  default_scope :order => 'students.name'
  
  def self.search(search)
    if(search)
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end

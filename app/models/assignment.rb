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
  
#  default_scope :order => 'assignments.created_at DESC'
  default_scope order('assignments.active DESC','assignments.created_at DESC')
  
  def self.array_of_assignments(assnlist)
    assignment_array = []
    unless assnlist.empty?
      assnlist.each do |ele|
        assignment_array << Assignment.where(:id => ele).first
      end
    end
    return assignment_array
  end
  
  def self.array_of_emails(assignment_array)
    email_array = []
    unless assignment_array.empty?
      assignment_array.each do |assignment|
        if email_array.include?(assignment.user.email)
        else
          email_array << assignment.user.email
        end
      end
    end    
    return email_array
  end
  
end

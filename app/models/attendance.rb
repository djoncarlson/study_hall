class Attendance < ActiveRecord::Base

  attr_accessible :missingstudents, :section
  belongs_to :user
  
  def self.list_of_assn_id(attendance_record)
    if attendance_record.nil?
      return []
    else
      as_ints = []
      attendance_record.missingstudents.split.each do |ele|
        as_ints << ele.delete("'").to_i
      end
      no_zeros = []
      as_ints.each do |ele|
        if ele == 0
        else
          no_zeros << ele
        end
      end
      return no_zeros
    end
  end
  
  
  
end

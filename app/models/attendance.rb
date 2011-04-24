class Attendance < ActiveRecord::Base

  attr_accessible :missingstudents, :section
  belongs_to :user
  
  def self.cleanup(attendance_record_hash)
    return attendance_record_hash.delete("'").delete("-").delete("\n").strip
  end
  
  def self.list_of_assn_id(attendance_record)
    if attendance_record.missingstudents.nil?
      return []
    else
      as_ints = []
      attendance_record.missingstudents.delete("-").delete("'").split.each do |ele|
        as_ints << ele.to_i
      end
      return as_ints
    end
  end

end

class Attendance < ActiveRecord::Base

  attr_accessible :missingstudents, :section, :all
  belongs_to :user
  
  def self.cleanup(attendance_record_hash)
    return attendance_record_hash.delete("'").delete("-").delete("\n").strip
  end
  
  def self.string_to_array(db_record)
    if db_record.nil?
      return []
    else
      as_ints = []
      db_record.delete("-").delete("'").split.each do |ele|
        as_ints << ele.to_i
      end
      return as_ints
    end
  end

end

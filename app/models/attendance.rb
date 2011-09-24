class Attendance < ActiveRecord::Base

  attr_accessible :missingstudents, :section, :all
  belongs_to :user
  
  default_scope order('attendances.created_at DESC')
    
  def self.cleanup(attendance_record_hash)
    return attendance_record_hash.delete("'").delete("-").delete("\n").delete('"').strip
  end
  
  def self.db_to_web(db_record)
    strip_deleted_students(string_to_array(db_record))
  end
  
  def self.string_to_array(db_record)
    if db_record.nil?
      return []
    else
      as_ints = []
      db_record.delete("-").delete("'").delete("\n").delete('"').strip.split.each do |ele|
        as_ints << ele.to_i
      end
      return as_ints
    end
  end
  
  def self.strip_deleted_students(student_array)
    clean = []
    unless student_array.nil?
      student_array.each do |ele|
        unless Student.where(:id => ele).empty?
          clean << ele
        end
      end
    end
    return clean
  end

end

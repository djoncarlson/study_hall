class Notifier < ActionMailer::Base
  default :from => "djoncarlson@gmail.com", :to => "dcarlson@cotopaxi.k12.ec"

  def attendance_taken(attendance_record)
    @attendance = attendance_record

#    @assnlist = Attendance.list_of_assn_id(attendance_record)
#    @assignment_array = Assignment.array_of_assignments(@attendance.missingstudents)
#    @email_array = Assignment.array_of_emails(@assignment_array)

#    @missingstudents_array = Attendance.string_to_array(@attendance.missingstudents)
#    @allstudents_array = Attendance.string_to_array(@attendance.all)
    
    @missingassignment_array = Assignment.array_of_assignments(@attendance.missingstudents)
    @allassignment_array = Assignment.array_of_assignments(@attendance.all)
    
    @email_array = Assignment.array_of_emails(@allassignment_array)
    
    mail :cc => @email_array, :subject => "Study Hall Attendance"

  end
end

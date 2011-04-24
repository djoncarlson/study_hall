class Notifier < ActionMailer::Base
  default :from => "djoncarlson@gmail.com", :to => "ewexler@cotopaxi.k12.ec"

  def attendance_taken(attendance_record)
    @attendance = attendance_record

#    @assnlist = Attendance.list_of_assn_id(attendance_record)
    @assignment_array = Assignment.array_of_assignments(@attendance.missingstudents)
    @email_array = Assignment.array_of_emails(@assignment_array)
    
    mail :cc => @email_array, :subject => "Study Hall Attendance"

  end
end

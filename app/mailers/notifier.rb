class Notifier < ActionMailer::Base
  default :from => "acstudyhall@gmail.com"
  
  def attendance_taken(attendance_record)
    @attendance = attendance_record
    
    @missingassignment_array = Assignment.array_of_assignments(@attendance.missingstudents)
    @allassignment_array = Assignment.array_of_assignments(@attendance.all)
    @email_array = Assignment.array_of_emails(@missingassignment_array)  

    mail :to => "gfigueroa@cotopaxi.k12.ec, ewexler@cotopaxi.k12.ec, sbrazinsky@cotopaxi.k12.ec", :cc => @email_array, :subject => "Study Hall Attendance"

  end
  
  def send_password(email, new_pass)
    @new_pass = new_pass
    @email = email

    mail :to => email, :subject => "Study Hall Password Reset"
  end
end

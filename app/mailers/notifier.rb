class Notifier < ActionMailer::Base
#  default :from => "hsstudyhall@cotopaxi.k12.ec"
  default :from => "acstudyhall@gmail.com"
  
  def attendance_taken(attendance_record)
    @attendance = attendance_record
    
    @missingassignment_array = Assignment.array_of_assignments(@attendance.missingstudents)
    @allassignment_array = Assignment.array_of_assignments(@attendance.all)
    @email_array = Assignment.array_of_emails(@missingassignment_array)  
# production
#    mail :to => "gfigueroa@cotopaxi.k12.ec, ewexler@cotopaxi.k12.ec, sbrazinsky@cotopaxi.k12.ec", :cc => @email_array, :subject => "Study Hall Attendance"
# testing
      mail :to => "djoncarlson@gmail.com", :subject => "Study Hall Attendance"

  end
  
  def one_week_reminder()
    @old_assignments = Assignment.week_old_assignments()
    @old_assignment_array = Assignment.array_of_assignments(@old_assignments)
    @old_assignment_emails = Assignment.array_of_emails(@old_assignment_array)
    unless @old_assignments.empty?
# production      
#      @old_assignments.each do |assn|
#       mail :to => assn.user.email, :subject => "Old Study Hall Assignment"
#      end
#      mail :to => @old_assignment_emails, :subject => "Old Study Hall Assignments"
# testing
      mail :to => "djoncarlson@gmail.com", :subject => "Old Study Hall Assignments"
    end
  end
  
  def send_password(email, new_pass)
    @new_pass = new_pass
    @email = email

    mail :to => email, :subject => "Study Hall Password Reset"
  end
end

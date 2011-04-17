class PagesController < ApplicationController
  def home
		@title = "Home"
  end
  
	def attendance
	  @attendance = Attendance.new
    @title = "Attendance"
    @attendance_list = current_user.fetch_students_for_attendance(params[:attendance_list])
#    @session_now = current_user.fetch_session_now
#    @section_list = current_user.fetch_students_for_attendance(@session_now)
    @session_in_words = current_user.convert_section_to_string(params[:attendance_list])
  end

end

class PagesController < ApplicationController
  def home
		@title = "Home"
  end
  
	def attendance
	  @attendance = Attendance.new
    @title = "Attendance"
    @attendance_list = current_user.fetch_students_for_attendance(params[:attendance_list])
    @attendance_ids = @attendance_list.collect(&:id)
    @session_in_words = current_user.convert_section_to_string(params[:attendance_list])
    @sections = {'Monday - Lunch' => 'mlunch', 'Monday - After' => 'mafter', 'Tuesday - Lunch' => 'tlunch', 'Tuesday - After' => 'tafter', 'Wednesday - Lunch' => 'wlunch', 'Wednesday - After' => 'wafter', 'Thursday - Lunch' => 'rlunch', 'Thursday - After' => 'rafter', 'Friday - Lunch' => 'flunch', 'Friday - After' => 'fafter'}
  end

end

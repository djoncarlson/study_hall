class PagesController < ApplicationController
  def home
		@title = "Home"
  end
  
	def attendance
	  @attendance = Attendance.new
    @title = "Attendance"
    if params[:attendance_list].blank?
    
      render 'attendance'
    
    else
      @attendance_list = current_user.fetch_students_for_attendance(params[:attendance_list])
    
      @attendance_ids = @attendance_list.collect(&:id)
      @session_in_words = current_user.convert_section_to_string(params[:attendance_list])
      @sections = {'Monday - Lunch' => 'mlunch', 'Monday - After' => 'mafter', 'Tuesday - Lunch' => 'tlunch', 'Tuesday - After' => 'tafter', 'Wednesday - Lunch' => 'wlunch', 'Wednesday - After' => 'wafter', 'Thursday - Lunch' => 'rlunch', 'Thursday - After' => 'rafter', 'Friday - Lunch' => 'flunch', 'Friday - After' => 'fafter'}
    end
  end

  def newYearPromotion
    if current_user.admin?
      Assignment.destroy_all
      Attendance.destroy_all
      Student.destroy_all('grade > 11')
      Student.all.each do |stu|
        stu.grade = stu.grade + 1
        stu.save
      end
      flash[:success] = "Database Updated"
      redirect_to students_path
    else
      flash[:notice] = "You do not have sufficient rights to perform that operation"
      redirect_to students_path
    end
  end
end

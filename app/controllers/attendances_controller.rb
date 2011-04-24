class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def show
    @attendance = Attendance.find(params[:id])
    @assnlist = Attendance.list_of_assn_id(@attendance)

    @assignment_array = Assignment.array_of_assignments(@assnlist)
    @email_array = Assignment.array_of_emails(@assignment_array)
    
  end
 
  def create
    @attendance = current_user.attendances.build(params[:attendance])

    clean_section = Attendance.cleanup(params[:section].first.first)
    @attendance.section = clean_section
    @attendance.missingstudents = params[:missingstudents]   

    if @attendance.save
      Notifier.attendance_taken(@attendance).deliver
      flash[:success] = "Attendance record created"
      redirect_to attendance_path(@attendance)
    else
      flash[:notice] = "Attendance not saved, something went terribly wrong..."
      render 'new'
    end
  end

end

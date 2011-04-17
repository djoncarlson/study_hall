class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def show
    @attendance = Attendance.find(params[:id])
    @assnlist = Attendance.list_of_assn_id(@attendance)
  end
 
  def create

    @attendance = current_user.attendances.build(params[:attendance])
    @attendance.missingstudents = params[:missingstudents]
    @attendance.section = params[:section]    
        
    if @attendance.save
      flash[:success] = "attendance record created"
      redirect_to attendance_path
    else
      flash[:notice] = "attendance not sent, something went terribly wrong..."
      render 'new'
    end
  end
  

end

class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def show
    @attendance = Attendance.find(params[:id])
    @missingstudents_array = Attendance.string_to_array(@attendance.missingstudents)
    @allstudents_array = Attendance.string_to_array(@attendance.all)
    
    @missingassignment_array = Assignment.array_of_assignments(@missingstudents_array)
    @allassignment_array = Assignment.array_of_assignments(@allstudents_array)
    
    @email_array = Assignment.array_of_emails(@allassignment_array)
    
  end
 
  def create
    @attendance = current_user.attendances.build(params[:attendance])

    @attendance.section = Attendance.cleanup(params[:section].first.first)
    @attendance.missingstudents = params[:missingstudents]
    @attendance.all = params[:all_ids]
    
    if @attendance.save
      #Notifier.attendance_taken(@attendance).deliver
      flash[:success] = "Attendance record created"
      redirect_to attendance_path(@attendance)
    else
      flash[:notice] = "Attendance not saved, something went terribly wrong..."
      render 'new'
    end
  end

end

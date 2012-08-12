class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def index
    @attendance_records = Attendance.all.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end
  
  def show
    @attendance = Attendance.find(params[:id])

    @missingstudents_array = Attendance.db_to_web(@attendance.missingstudents)
    @allstudents_array = Attendance.db_to_web(@attendance.all)
        
    @missingassignment_array = Assignment.array_of_assignments(@missingstudents_array)
    @allassignment_array = Assignment.array_of_assignments(@allstudents_array)
    
    @email_array = Assignment.array_of_emails(@missingassignment_array)
    
  end
 
  def create
    @attendance = current_user.attendances.build(params[:attendance])
    
    @attendance.section = Attendance.cleanup(params[:section].first.first)
    @attendance.missingstudents = params[:missingstudents]
    @attendance.all = params[:all_ids]
    
    if @attendance.save
      Notifier.attendance_taken(@attendance).deliver
      Notifier.one_week_reminder().deliver
      flash[:success] = "Attendance record created"
      redirect_to attendance_path(@attendance)
    else
      flash[:notice] = "Attendance not saved, something went wrong..."
      render 'new'
    end
  end

end

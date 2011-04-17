class AssignmentsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
 
  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = current_user.assignments.build(params[:assignment])
    @assignment.student_id = params[:assignment][:student_id]
    @assignment.active = params[:assignment][:active]

    if @assignment.save
      flash[:success] = "Assignment Created"
      redirect_to student_path(params[:assignment][:student_id])
    else
      flash[:notice] = "Assignment Not Created"
      render 'new'
    end
  end
  
  def show
    @assignment = Assignment.find(params[:id])
    @student = @assignment.student
  end
  
  def index
    @active_assignments = Assignment.where(:active => true)
    @inactive_assignments = Assignment.where(:active => false)
    @assignments = Assignment.all
  end
  
  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      flash[:success] = "Assignments updated"
      redirect_to assignment_path(@assignment)
    else
      flash[:notice] = "Something went wrong"
      redirect_to assignment_path(@assignment)
    end
  end
  
  def inactivate

  end
  
  def destroy
    Assignment.find(params[:id]).update_attributes(:active => 0)
    flash[:success] = "Assignment inactivated"
    redirect_to student_path(Assignment.find(params[:id]).student)
  end
  

end

class StudentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
#  before_filter :authorized_user, :only => :destroy
  
  def new
    @student = Student.new
  end  
  
  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:success] = "Student created!"
      redirect_to students_path
    else
      flash[:notice] = "Student was not created, something went terribly wrong..."
      render 'new'
    end
  end
    
  def destroy
    Student.find(params[:id]).destroy
    flash[:success] = "Student Record Deleted"
    redirect_to students_path
  end
  
  def index
    @students = Student.search(params[:search])
    @student = Student.new 
  end

  def show
		@student = Student.find(params[:id])
		@assignment = Assignment.new
		@assignments = Assignment.where(:student_id => @student)
		@active_assignments = @assignments.where(:active => true).to_a
		@inactive_assignments = @assignments.where(:active => false).to_a
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:success] = "Student updated"
      redirect_to @student
    else
      @title = "Edit student"
      render 'edit'
    end
  end
  
  def edit
    @student = Student.find(params[:id])
  end
  
 
  private
  
    def authorized_user
      @student = Student.find(params[:id])
      redirect_to root_path unless current_user?(@student.user)
    end

end

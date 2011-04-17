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
      redirect_to student_path(@student)
    else
      flash[:notice] = "Student was not created, something went terribly wrong..."
      render 'new'
    end
  end
    
  def destroy
    @student.destroy
    redirect_to root_path
  end
  
  def index
#    if params[:search]
#      @students = Student.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
#    else
#      @students = Student.all
#    end
    @students = Student.search(params[:search])
    @student = Student.new 
  end

  def show
		@student = Student.find(params[:id])
		@assignment = Assignment.new
		@assignments = Assignment.where(:student_id => @student)
		@active_assignments = @assignments.where(:active => true)
		@inactive_assignments = @assignments.where(:active => false)
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

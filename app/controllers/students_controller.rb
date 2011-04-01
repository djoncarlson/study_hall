class StudentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @student = current_user.students.build(params[:student])
    if @student.save
      flash[:success] = "Student created!"
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
  def destroy
    @student.destroy
    redirect_back_or root_path
  end
  
  def show
		@student = Student.find(params[:id])    
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:success] = "Student updated"
      redirect_to student_path(@student)
    else
      @title = "Edit student"
      render 'edit'
    end
  end
  
  def edit
  end
  
  private
  
    def authorized_user
      @student = Student.find(params[:id])
      redirect_to root_path unless current_user?(@student.user)
    end

end

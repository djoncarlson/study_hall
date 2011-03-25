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
  
  private
  
    def authorized_user
      @student = Student.find(params[:id])
      redirect_to root_path unless current_user?(@student.user)
    end

end

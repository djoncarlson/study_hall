class PagesController < ApplicationController
  def home
		@title = "Home"
		if signed_in?
  		@student = Student.new
  		@feed_items = current_user.feed(params[:attendance]).paginate(:page => params[:page])
		  @teacher = current_user.owner(params[:user_id])
		end
  end
  
	def help
		@title = "Help"
	end
	
  def contact
		@title = "Contact"
  end

	def about
		@title = "About"
	end
	
	def attendance
    @title = "Attendance"
    @section_list = current_user.fetch_students_for_attendance(params[:attendance])

  end
 

end

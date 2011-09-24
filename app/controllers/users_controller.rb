class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
 		@assignments = Assignment.where(:user_id => @user)
		@active_assignments = @assignments.where(:active => true)
		@inactive_assignments = @assignments.where(:active => false)
  end
  
	def show
		@user = User.find(params[:id])
		@title = @user.name
		@assignments = Assignment.where(:user_id => @user)
		@active_assignments = @assignments.where(:active => true).to_a
		@inactive_assignments = @assignments.where(:active => false).to_a
	end
	
  def new
    @user = User.new
		@title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Study Hall!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def forgot_password
    if request.post?
      u = User.find_by_email(params[:email])
      if u and u.send_new_password
        flash[:success]  = "A new password has been sent to your email."
        redirect_to signin_path
      else
        flash[:error]  = "The email address you entered is not in the database, please try again."
      end
    end
  end
  
  private

# Moved to app/helpers/sessions_helper.rb   
#    def authenticate
#      deny_access unless signed_in?
#    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end 
end

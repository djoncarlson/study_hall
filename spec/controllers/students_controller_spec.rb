require 'spec_helper'

describe StudentsController do
  render_views
  
  describe "access control" do
    
    it "should deny access to create" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :assignment => "" }
      end
      
      it "should not create a student instance" do
        lambda do
          post :create, :student => @attr
        end.should_not change(Student, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "Georgey Pwer", :assignment => "some stuff" }
      end
      
      
      it "should create a student" do
         lambda do
          post :create, :student => @attr
        end.should change(Student, :count).by(1)
      end
 
      it "should redirect_to the users page" do
        post :create, :student => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        post :create, :student => @attr
        flash[:success].should =~ /student created/i
      end
    end
  end
end


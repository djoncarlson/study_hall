require 'spec_helper'

describe Student do
  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "Some Kid", :assignment => "Read ch 15", :instructions => "bring your book!" }
  end
  
  it "should create a new instance given valid attributes" do
    @user.students.create!(@attr)
  end
  
  describe "user associations" do
    before(:each) do
      @student = @user.students.create(@attr)
    end
    
    it "should have a user attribute" do
      @student.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @student.user_id.should == @user.id
      @student.user.should == @user
    end
  end
  
  describe "validations" do
    
    it "should require non-blank name" do
      @user.students.build(:name => "  ").should_not be_valid
    end
  end 
end

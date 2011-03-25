require 'spec_helper'

describe User do
  
  before(:each) do
  	@attr = { 
  		:name => "Example User",
	  	:email => "user@example.com",
	  	:password => "foobar",
	  	:password_confirmation => "foobar" 
  	}
  end
  
  it "should create a new instance given valid attributes" do
  	User.create!(@attr)
  end
    
  it "should require a name" do
  	no_name_user = User.new(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
  	no_email_user = User.new(@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
	end
	
	it "should reject really long names - greater than 50" do
		long_name = "a" *51
		long_name = User.new(@attr.merge(:name => long_name))
		long_name.should_not be_valid
	end 
	
	it "should accept valid email addresses" do
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end
	
	it "should reject invalid email addresses" do
		addresses = %w[user@foo,com user_at_foo.org exampe.user@foo]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
		end
	end
	
	it "should reject a duplicate email address" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	
	it "should reject email address that is duplicate regardless of case" do
		upcased_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	describe "password validations" do
		
		it "should require a password" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
		end
		
		it "should require a matching password confirmation" do
			User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
		end
		
		it "should reject short passwords" do
			short = "a" * 5
			hash = @attr.merge(:password => short, :password_confirmation => short)
			User.new(hash).should_not be_valid
		end
		
		it "should reject long passwords" do
			long = "a" * 41
			hash = @attr.merge(:password => long, :password_confirmation => long)
			User.new(hash).should_not be_valid
		end
	end
	
	describe "password encryption" do
		
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end
	
		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
		
		describe "has_password? method" do
			it "should be true if passwords match" do
				@user.has_password?(@attr[:password]).should be_true
			end
			
			it "should be false if the passwords don't match" do
				@user.has_password?("invalid").should be_false
			end
		end
		describe "authenticate method" do
			it "should return nil on email/password mismatch" do
				wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
				wrong_password_user.should be_nil
			end
			
			it "should return nil for email with no user" do
				no_email = User.authenticate("bar@foo.com", @attr[:password])
				no_email.should be_nil
			end
			
			it "should return the user on email/password match" do
				matching_user = User.authenticate(@attr[:email], @attr[:password])
				matching_user.should == @user
			end
		end
	end
	describe "admin attribute" do 
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @user.should_not be_admin
    end
    
    it "should be convertible to admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
  describe "student associations" do
    before(:each) do
      @user = User.create(@attr)
      @st1 = Factory(:student, :user => @user, :created_at => 1.day.ago)
      @st2 = Factory(:student, :user => @user, :created_at => 1.hour.ago)
    end
    
    it "should have a students attribute" do
      @user.should respond_to(:students)
    end

    it "should have the right students in the right order" do
      @user.students.should == [@st2, @st1]
    end
    
    it "should destroy associated students" do
      @user.destroy
      [@st1, @st2].each do |student|
        Student.find_by_id(student.id).should be_nil
      end
    end
    describe "status feed" do
      it "should have a feed" do
        @user.should respond_to(:feed)
      end
      it "should include the user's students" do
        @user.feed.include?(@st1).should be_true
        @user.feed.include?(@st2).should be_true
      end
      
      it "should not include a different users's students" do
        st3 = Factory(:student, :user => Factory(:user, :email => Factory.next(:email)))
        @user.feed.include?(st3).should be_false
      end
    end
  end
end

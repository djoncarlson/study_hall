# == Schema Information
# Schema version: 20110319122819
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require 'digest'
class User < ActiveRecord::Base
  include ActiveModel::Validations
  
  class CodeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must match the correct secret code." unless value =~ /\Awexification/i
    end
  end
  
	attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :secretcode
	
	has_many :students, :dependent => :destroy
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  secret_regex = /(wexification)/i

	validates :name, 	:presence => true,
										:length => { :maximum => 50 }
	validates :email, :presence => true,
										:format => { :with => email_regex },
										:uniqueness => { :case_sensitive => false}
	validates :password,	:presence	 		=> true,
												:confirmation => true,
												:length				=> { :within => 6..40 }
  validates :secretcode,  :presence => true, 
                          :code => true

	before_save :encrypt_password
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)		
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
	  user = find_by_id(id)
	  (user && user.salt == cookie_salt) ? user : nil
  end
	
	def feed(section)
    if section.nil?
      return Student.all
      #Student.where("user_id = ?", id)  
    else  
	    return Student.where(section => true)
    end
  end
  
  def fetch_students_for_attendance(section)
    return Student.where(section => true)
  end
	
	private
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(self.password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}-#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{self.password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
		
end


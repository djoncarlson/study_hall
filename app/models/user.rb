require 'digest'
class User < ActiveRecord::Base
  include ActiveModel::Validations
  
  class CodeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must match the correct secret code." unless value =~ /\Aeducation/i
    end
  end
  
	attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :secretcode, :admin
	
  has_many :assignments, :dependent => :destroy
  has_many :attendances, :dependent => :destroy
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

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
    if section.nil?
      return Assignment.where(:active => true)
    else
      return Assignment.where(section => true, :active => true)
    end
  end
  
  def fetch_detention_for_attendance(section)
    if section.nil?
      return Assignment.where(:active => true)
    else
#      return Assignment.where("section = ? AND active = ? AND detention = ?", true, true, true)
      return Assignment.where(section => true, :active => true, :detention => true)
    end
  end
  
  def fetch_studyhall_for_attendance(section)
    if section.nil?
      return Assignment.where(:active => true)
    else
#      return Assignment.where("section = ? AND active = ? AND detention = ?", true, true, false)
      return Assignment.where(section => true, :active => true, :detention => false)
    end
  end
  
  
  def convert_section_to_string(section)
    if section.nil?
      return "All Active Participants"
    else
      if section.first == 'm'
        day = 'Monday'
      elsif section.first == 't'        
        day = 'Tuesday'
      elsif section.first == 'w'
        day = 'Wednesday'
      elsif section.first == 'r'
        day = 'Thursday'
      else section.first == 'f'
        day = 'Friday'
      end
      
      if section[1] == 'l'
        time = ' at Lunch'
      else
        time = ' After School'      
      end
      return day + time
      
    end
  end
  
  def fetch_session_now()
    hour = Time.now().hour
    day = Time.now().strftime('%A').first.downcase
    if 10 <= hour && hour <= 14
      session = "lunch"
    else
      session = "after"
    end
    if day == "t"
      if Time.now().strftime('%A') == "Tuesday"
        day = "t"
      else
        day = "r"
      end
    end
    section = day + session
    
    return section 
  end
  
  def get_email_list(list_of_assn_id)
  end    
  
  def send_new_password
    new_pass = self.random_string
    self.password = self.password_confirmation = new_pass
    self.save
    Notifier.send_password(email, new_pass).deliver
  end
  
	def random_string
	  rand(36**10).to_s(36)
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
		
		def reset_password(string)
		  self.encrypted_password = encrypt(string)
	  end
		
end


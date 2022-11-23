class Account < ApplicationRecord
	has_secure_password 
	has_one_attached :userprofile
	has_many :addresses ,dependent: :destroy
	has_one :cart ,dependent: :destroy
	validate :password_check
	accepts_nested_attributes_for :cart, allow_destroy: true
	accepts_nested_attributes_for :addresses, allow_destroy: true
	validates :userprofile, :fullname, :country, presence: true
	validates :phoneno,numericality: true, :length => { :is => 10 },presence: true
	validates :countrycode, presence: true, numericality: {only_integer: true}
	validates_format_of :email, :with => /\A((?=.*\d)+[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,presence: true
	
  def password_check
    return if password&.match(/^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$/)
    errors.add :password, ' Password must contain 1 uppercasse , 1 lowercase, 1 Special character, 1 digit '
  end

  def create_unique_number
  	self.uniquenumber = create_new_unique_number
  	self.uniquenumber
  end

  def create_new_unique_number
  	accounts = Account.all
  	if accounts.present?
  		if accounts&.last&.uniquenumber&.include?("ACC-")
  			accounts&.last&.uniquenumber&.succ
  		else
  			format('ACC-%05d', 0)
  		end
  	else
  		format('ACC-%05d', 0)
  	end
  end
  
end
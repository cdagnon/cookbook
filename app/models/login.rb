class Login < ActiveRecord::Base
	belongs_to :account
	
	validates_uniqueness_of :username
end

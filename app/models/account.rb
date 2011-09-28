class Account < ActiveRecord::Base
	has_one :login
	has_many :recipes, :foreign_key => :entered_by_id
	
	validates_uniqueness_of :name
end

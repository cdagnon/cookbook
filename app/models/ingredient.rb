class Ingredient < ActiveRecord::Base
	has_many :recipe_ingredients
	belongs_to :parent, :class_name => "Ingredient", :foreign_key => :parent_id
	has_many :children, :class_name => "Ingredient"
	
	validates_uniqueness_of :name
end

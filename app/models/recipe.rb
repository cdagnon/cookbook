class Recipe < ActiveRecord::Base
	belongs_to :account, :foreign_key => :entered_by_id
	has_many :recipe_ingredients	#, :class_name => :RecipeIngredients
	has_many :ingredients, :through => :recipe_ingredients
end

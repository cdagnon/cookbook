module ApplicationHelper
	# SEE: ApplicationController for related methods/setup
	def logged_in
		! session[:current_user_account].nil?
	end
	
	def abbreviate_and_pluralize_ingredients recipe
		recipe.recipe_ingredients.each{|ri| ri.abbreviate_and_pluralize}
	end

	def multiply_ingredients recipe, str_multiplier
		mult = 1
		div = 1
		if str_multiplier =~ /\A[1-9][0-9]?\Z/ then
			mult = str_multiplier.to_i
		else
			str_multiplier =~ /\A([1-9][0-9]?)\/([1-9][0-9]?)\Z/
			mult = $1.to_i
			div = $2.to_i
		end
		recipe.recipe_ingredients.each{|ri| ri.multiply(mult, div)}
	end
end

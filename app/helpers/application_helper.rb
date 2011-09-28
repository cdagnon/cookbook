module ApplicationHelper
	# SEE: ApplicationController for related methods/setup
	def logged_in
		! session[:current_user_account].nil?
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
#Rails.logger.warn("MULT=[#{mult}]  DIV=[#{div}]   INPUT=[#{str_multiplier}]")
		recipe.recipe_ingredients.each{|ri| ri.multiply(mult, div)}
	end
end

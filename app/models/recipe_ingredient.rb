class RecipeIngredient < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :ingredient
	
	def multiply mult, div
#puts "MULT=[#{mult}]  DIV=[#{div}]"
		denom	= 1
		nom		= 1
		is_decimal = false
		is_fraction = false
		if quantity_count =~ /\A([1-9][0-9]?)\Z/ then
			nom = $1.to_i
		elsif quantity_count =~ /\A(([0-9]|[1-9][0-9]*)\.[0-9]+)\Z/ then
			nom = $1.to_f
			is_decimal = true
		elsif quantity_count =~ /\A([1-9][0-9]?)? ?([1-9][0-9]?)\/([1-9][0-9]?)\Z/
			base = $1 ? $1.to_i : 0
			denom	= $3 ? $3.to_i : 1
			nom		= $2.to_i + (denom * base)
			is_fraction = true
#puts "BASE=[#{base}]  DENOM=[#{denom}]  [#{$1}][#{$2}][#{$3}][#{$4}]"
		else
			# Nothing matches - what is it?
			raise "Unrecognizable value: #{quantity_count}"
		end
#puts "NOM=[#{nom}]  DENOM=[#{denom}]"

		nom2	= (mult * nom)
		denom2	= (div * denom)
		new_value = nom2/denom2.to_f
#puts "NOM2=[#{nom2}]  DENOM2=[#{denom2}]  NewVal=[#{new_value}]"
		if( new_value.to_i == new_value) then
			new_value = new_value.to_i
		elsif( ! is_decimal ) then	# Must deal with non-whole number
			if(nom2 > denom2) then
				base = nom2/denom2.to_i
				nom3 = (nom2 - (base*denom2))
				gcd = nom3.gcd denom2			# reduce nom3/denom2
				new_value = "#{base} #{nom3/gcd}/#{denom2/gcd}"
			else
				gcd = nom2.gcd denom2			# reduce nom2/denom2
				new_value = "#{nom2/gcd}/#{denom2/gcd}"
			end
		end
		self.quantity_count = new_value.to_s
	end
end

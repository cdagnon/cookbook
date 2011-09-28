class RecipeIngredient < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :ingredient
	
	IMPERIAL_VOLUME = 
	[{:name => 'teaspoon',		:abbrv => 'tspn',	:step_up => {:unit => 'tablespoon', :count => 3}},
	 {:name => 'tablespoon',	:abbrv => 'tbspn',	:step_up => {:unit => 'cup', :count => 16}},
	 {:name => 'cup',			:abbrv => 'cu',		:step_up => {:unit => 'pint', :count => 2},	:upgrade => false},
	 {:name => 'pint',			:abbrv => 'pt',		:step_up => {:unit => 'quart', :count => 2}},
	 {:name => 'quart',			:abbrv => 'qt',		:step_up => {:unit => 'gallon', :count => 4}},
	 {:name => 'gallon',		:abbrv => 'gal'},]

	IMPERIAL_WEIGHT =
	[{:name => 'ounce',			:abbrv => 'oz',		:step_up => {:unit => 'pound', :count => 16}},
	 {:name => 'pound',			:abbrv => 'lb'}]

	METRIC_VOLUME	=
	[{:name => 'milliliter',	:abbrv => 'ml',		:step_up => {:unit => 'liter', :count => 1000}},
	 {:name => 'liter',			:abbrv => 'L'},]

	METRIC_WEIGHT	=
	[{:name => 'gram',			:abbrv => 'g',		:step_up => {:unit => 'kilogram', :count => 1000}},
	 {:name => 'kilogram',		:abbrv => 'kg'},]

	OTHER_MEASUREMENTS =
	[
	 {:name => 'can (4oz)',		:abbrv => 'can'},
	 {:name => 'can (8oz)',		:abbrv => 'can'},
	 {:name => 'can (16oz)',	:abbrv => 'can'},
	 {:name => 'can (other)',	:abbrv => 'can'},
	 {:name => 'jar (1 pint)',	:abbrv => 'jar'},
#	 {:name => ''},
	 {:name => 'package',		:abbrv => 'pkg'},]

	ALL_MEASURES		= [IMPERIAL_VOLUME, IMPERIAL_WEIGHT, METRIC_VOLUME, METRIC_WEIGHT, OTHER_MEASUREMENTS].flatten
	ALL_MEASURES_MAP	= ALL_MEASURES.inject({}) do |map, input|  map[input[:name]] = input; map end


	def abbreviate_and_pluralize
		info = ALL_MEASURES_MAP[self.quantity_type]
		self.quantity_type = "#{info[:abbrv]}" if info[:name].size() > 4
		self.quantity_type += 's' if measurement_to_float() > 1
	end

	def measurement_to_float
		interpret_measurement(self.quantity_count)[0]
	end
	def interpret_measurement quantity
		denom	= 1
		nom		= 1
		is_decimal = false
		is_fraction = false
		if quantity =~ /\A([1-9][0-9]?)\Z/ then
			nom = $1.to_i
		elsif quantity =~ /\A(([0-9]|[1-9][0-9]*)\.[0-9]+)\Z/ then
			nom = $1.to_f
			is_decimal = true
		elsif quantity =~ /\A([1-9][0-9]?)? ?([1-9][0-9]?)\/([1-9][0-9]?)\Z/
			base = $1 ? $1.to_i : 0
			denom	= $3 ? $3.to_i : 1
			nom		= $2.to_i + (denom * base)
			is_fraction = true
#puts "BASE=[#{base}]  DENOM=[#{denom}]  [#{$1}][#{$2}][#{$3}][#{$4}]"
		else
			# Nothing matches - what is it?
			raise "Unrecognizable value: #{quantity_count}"
		end
		[(nom/denom.to_f), {:is_decimal => is_decimal, :is_fraction => is_fraction,
							:nom => nom, :denom => denom, :base => base}]
	end
	
	def multiply mult, div
#puts "MULT=[#{mult}]  DIV=[#{div}]"
		info = interpret_measurement self.quantity_count
		value, base, nom, denom, is_decimal, is_fraction = info[0], info[1][:base], info[1][:nom], info[1][:denom], info[1][:is_decimal], info[1][:is_fraction]
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

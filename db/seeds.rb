# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Account.create( :id => 1, :name => "Admin", :language => "English(U.S.)", :location_country => "U.S.A.", :location_state => "WI")
Login.create(:id => 1, :username => "administrator", :encrypted_pwd => "somethingUnique", :account_id => 1)

flour = Ingredient.create( :name => 'flour' )
Ingredient.create([
	{ :name => 'flour, white', :parent_id => flour.id },
	{ :name => 'flour, wheat', :parent_id => flour.id },
	{ :name => 'flour, rice', :parent_id => flour.id },
	{ :name => 'flour, corn', :parent_id => flour.id },
	{ :name => 'flour, white, bleached', :parent_id => flour.id },
	{ :name => 'flour, pancake', :parent_id => flour.id },
	{ :name => 'flour, bisquick', :parent_id => flour.id },
	{ :name => 'flour, sorghum', :parent_id => flour.id },
#	{ :name => 'flour, ', :parent_id => flour.id },
])
sugar = Ingredient.create( :name => 'sugar' )
Ingredient.create([
	{ :name => 'sugar, white', :parent_id => sugar.id },
	{ :name => 'sugar, white, granulated', :parent_id => sugar.id },
	{ :name => 'sugar, raw', :parent_id => sugar.id },
	{ :name => 'sugar, brown', :parent_id => sugar.id },
	{ :name => 'sugar, dark brown', :parent_id => sugar.id },
	{ :name => 'sugar, powdered', :parent_id => sugar.id },
	{ :name => 'sugar, crystalized', :parent_id => sugar.id },
#	{ :name => 'sugar, ', :parent_id => sugar.id },
])
water = Ingredient.create( :name => 'water' )
Ingredient.create([
	{ :name => 'water, cold', :parent_id => water.id },
	{ :name => 'water, tap', :parent_id => water.id },
	{ :name => 'water, hot', :parent_id => water.id },
	{ :name => 'water, boiling', :parent_id => water.id },
	{ :name => 'water, filtered', :parent_id => water.id },
#	{ :name => 'water, ', :parent_id => water.id },
])
fruit = Ingredient.create( :name => 'fruit' )
Ingredient.create([
	{ :name => 'fruit, apple', :parent_id => fruit.id },
	{ :name => 'fruit, cherry', :parent_id => fruit.id },
	{ :name => 'fruit, raspberry', :parent_id => fruit.id },
	{ :name => 'fruit, peach', :parent_id => fruit.id },
	{ :name => 'fruit, apricot', :parent_id => fruit.id },
#	{ :name => 'fruit, apple, Red Delicious', :parent_id => fruit.id },
	{ :name => 'fruit, blueberry', :parent_id => fruit.id },
	{ :name => 'fruit, grape', :parent_id => fruit.id },
	{ :name => 'fruit, boisenberry', :parent_id => fruit.id },
	{ :name => 'fruit, melon', :parent_id => fruit.id },
#	{ :name => 'fruit, ', :parent_id => fruit.id },
])
Ingredient.create([
	{ :name => 'allspice' },
	{ :name => 'basil' },
	{ :name => 'cinnamon' },
	{ :name => 'rosemary' },
	{ :name => 'syrup' },
	{ :name => 'cornstarch' },
	{ :name => 'nutmeg' },
	{ :name => 'tumeric' },
	{ :name => 'ginger' },
	{ :name => 'oregano' },
	{ :name => 'thyme' },
	{ :name => 'sage' },
	{ :name => 'egg(s)' },
	{ :name => 'butter' },
#	{ :name => '' },
])

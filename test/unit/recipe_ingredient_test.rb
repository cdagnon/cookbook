require 'test_helper'
 
class RecipeIngredientTest < ActiveSupport::TestCase
# Identity tests
  test "multiplying ingredients 1 x 1" do
  	  ri = RecipeIngredient.new( :quantity_count => '1', :quantity_type => 'cup' )
  	  ri.multiply( 1, 1 )
  	  assert_equal 1, ri.quantity_count.to_i
  end
  test "multiplying ingredients 2 x 1" do
  	  ri = RecipeIngredient.new( :quantity_count => '2', :quantity_type => 'cup' )
  	  ri.multiply( 1, 1 )
  	  assert_equal 2, ri.quantity_count.to_i
  end
  test "multiplying ingredients 1/2 x 1" do
  	  ri = RecipeIngredient.new( :quantity_count => '1/2', :quantity_type => 'cup' )
  	  ri.multiply( 1, 1 )
  	  assert_equal '1/2', ri.quantity_count
  end
  test "multiplying ingredients 0.5 x 1" do
  	  ri = RecipeIngredient.new( :quantity_count => '0.5', :quantity_type => 'cup' )
  	  ri.multiply( 1, 1 )
  	  assert_equal '0.5', ri.quantity_count
  end
  test "multiplying ingredients 1.5 x 1" do
  	  ri = RecipeIngredient.new( :quantity_count => '1.5', :quantity_type => 'cup' )
  	  ri.multiply( 1, 1 )
  	  assert_equal '1.5', ri.quantity_count
  end
  test "multiplying ingredients 1 1/2 x 1" do
  	  ri = RecipeIngredient.new( :quantity_count => '1 1/2', :quantity_type => 'cup' )
  	  ri.multiply( 1, 1 )
  	  assert_equal '1 1/2', ri.quantity_count
  end

# Double
  test "multiplying ingredients 1 x 2" do
  	  ri = RecipeIngredient.new( :quantity_count => '1', :quantity_type => 'cup' )
  	  ri.multiply( 2, 1 )
  	  assert_equal 2, ri.quantity_count.to_i
  end
  test "multiplying ingredients 1.5 x 2" do
  	  ri = RecipeIngredient.new( :quantity_count => '1.5', :quantity_type => 'cup' )
  	  ri.multiply( 2, 1 )
  	  assert_equal '3', ri.quantity_count
  end
  test "multiplying ingredients 1 1/2 x 2" do
  	  ri = RecipeIngredient.new( :quantity_count => '1 1/2', :quantity_type => 'cup' )
  	  ri.multiply( 2, 1 )
  	  assert_equal '3', ri.quantity_count
  end
  test "multiplying ingredients 1 1/3 x 2" do
  	  ri = RecipeIngredient.new( :quantity_count => '1 1/3', :quantity_type => 'cup' )
  	  ri.multiply( 2, 1 )
  	  assert_equal '2 2/3', ri.quantity_count
  end
  test "multiplying ingredients 5/3 x 2" do
  	  ri = RecipeIngredient.new( :quantity_count => '5/3', :quantity_type => 'cup' )
  	  ri.multiply( 2, 1 )
  	  assert_equal '3 1/3', ri.quantity_count
  end

# Halve
  test "multiplying ingredients 1 x 1/2" do
  	  ri = RecipeIngredient.new( :quantity_count => '1', :quantity_type => 'cup' )
  	  ri.multiply( 1, 2 )
  	  assert_equal '1/2', ri.quantity_count
  end
  test "multiplying ingredients 4 x 1/2" do
  	  ri = RecipeIngredient.new( :quantity_count => '4', :quantity_type => 'cup' )
  	  ri.multiply( 1, 2 )
  	  assert_equal '2', ri.quantity_count
  end
  test "multiplying ingredients 13 x 1/2" do
  	  ri = RecipeIngredient.new( :quantity_count => '13', :quantity_type => 'cup' )
  	  ri.multiply( 1, 2 )
  	  assert_equal '6 1/2', ri.quantity_count
  end

# 2/3s
  test "multiplying ingredients 1 x 2/3" do
  	  ri = RecipeIngredient.new( :quantity_count => '1', :quantity_type => 'cup' )
  	  ri.multiply( 2, 3 )
  	  assert_equal '2/3', ri.quantity_count
  end
  test "multiplying ingredients 3 x 2/3" do
  	  ri = RecipeIngredient.new( :quantity_count => '3', :quantity_type => 'cup' )
  	  ri.multiply( 2, 3 )
  	  assert_equal '2', ri.quantity_count
  end
  test "multiplying ingredients 1 1/2 x 2/3" do
  	  ri = RecipeIngredient.new( :quantity_count => '1 1/2', :quantity_type => 'cup' )
  	  ri.multiply( 2, 3 )
  	  assert_equal '1', ri.quantity_count
  end
  test "multiplying ingredients 1/2 x 2/3" do
  	  ri = RecipeIngredient.new( :quantity_count => '1/2', :quantity_type => 'cup' )
  	  ri.multiply( 2, 3 )
  	  assert_equal '1/3', ri.quantity_count
  end
  test "multiplying ingredients 1/4 x 2/3: Reduce fractions!" do
  	  ri = RecipeIngredient.new( :quantity_count => '1/4', :quantity_type => 'cup' )
  	  ri.multiply( 2, 3 )
  	  assert_equal '1/6', ri.quantity_count
  end
end

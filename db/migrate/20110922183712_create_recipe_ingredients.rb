class CreateRecipeIngredients < ActiveRecord::Migration
  def self.up
  	create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.string :quantity_type
      t.string :quantity_count
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_ingredients
  end
end

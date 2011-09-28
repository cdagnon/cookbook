class AddSourceToRecipes < ActiveRecord::Migration
  def self.up
  	  add_column :recipes, :source, :string
  end

  def self.down
  	  remove_column :recipes, :source
  end
end

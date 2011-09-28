class AddCreatedByToIngredients < ActiveRecord::Migration
  def self.up
  	  add_column :ingredients, :created_by_account_id, :integer
  end

  def self.down
  	  remove_column :ingredients, :created_by_account_id
  end
end

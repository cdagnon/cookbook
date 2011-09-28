class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.text :directions
      t.integer :entered_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end

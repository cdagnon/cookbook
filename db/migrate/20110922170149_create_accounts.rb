class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.text :background
      t.string :language
      t.string :location_state
      t.string :location_country
      t.timestamp :registered_at

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end

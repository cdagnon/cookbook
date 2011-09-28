class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :username
      t.string :encrypted_pwd
      t.string :salt
      t.timestamp :last_logged_in_at
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end

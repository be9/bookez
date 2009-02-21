class ChangeUserForAuthlogic < ActiveRecord::Migration
  def self.up
    drop_table :users

    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :users

    create_table :users do |t|
      t.string :login, :limit => 40
      t.string :identity_url      
      t.string :name, :limit => 100, :default => '', :null => true
      t.string :email, :limit => 100
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
      t.string :remember_token, :limit => 40
      t.string :activation_code, :limit => 40
      t.string :state, :null => :no, :default => 'passive'      
      t.datetime :remember_token_expires_at
      t.datetime :activated_at
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

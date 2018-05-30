class User < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
  		t.string :first_name
  		t.string :last_name
  		t.string :email
  		t.string :password
  		t.string :password_digest
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
  	end
  end
end

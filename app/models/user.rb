class User < ApplicationRecord
	has_secure_password
	has_many :list
  has_many :authentications, dependent: :destroy

 def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
    name: auth_hash["info"]["name"],
    email: auth_hash["info"]["email"],
    password: SecureRandom.hex(10)

   )
   user.authentications << authentication
   return user
 end

 # grab google to access google for user data
 def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
 end

def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
  data = access_token.info
  if (User.admins.include?(data.email))
    user = User.find_by(email: data.email)
    if user
      user.provider = access_token.provider
      user.uid = access_token.uid
      user.token = access_token.credentials.token
      user.save
      user
    else
      redirect_to new_user_registration_path, notice: "Error."
    end
  end
end
 
end
	

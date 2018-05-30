# OmniAuth.config.logger = Rails.logger
# Rails.application.config.middleware.use OmniAuth::Builder do
# 	provider :facebook, ENV['facebook_app_id'], ENV["facebook_app_secret"]

# end

#  provider :facebook, Rails.application.secrets.facebook_app_id,
#  Rails.application.secrets.facebook_app_secret, scope: 'public_profile', info_fields: 'id,name,link'
# end

OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, Rails.application.secrets.facebook_app_id,
 Rails.application.secrets.facebook_app_secret, scope: 'public_profile', info_fields: 'id,name,link'
end
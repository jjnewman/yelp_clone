Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"],
  :provider_ignores_state => true,
  {:client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}},
                # :scope => 'email,user_birthday', :display => 'popup'
  OmniAuth.config.logger = Rails.logger
end





# provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"], 
           # {:client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
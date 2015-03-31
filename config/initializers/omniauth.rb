provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"], 
           {:client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
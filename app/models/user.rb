class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :restaurants

# devise_scope :user do
#   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
# end

# def self.from_omniauth(auth)
#   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#     user.email = auth.info.email
#     user.password = Devise.friendly_token[0,20]
#   end
# end


 def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    user = User.create(provider:auth.provider,
                       uid:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20]
                      )
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:runkeeper], :authentication_keys => [:uid]

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = "#{auth.uid}@runkeeper.com"
     user.password = Devise.friendly_token[0,20]
     user.birthday = auth.extra.raw_info.birthday
     user.name = auth.info.name
     user.auth_token = auth.credentials.token
    #  user.skip_confirmation!
   end
  end
end

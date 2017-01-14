class User < ApplicationRecord
  has_many :events
  # after_create :connect_bitcoin_account

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
   end
  end
  def connect_bitcoin_account
    account = BtcAccount.create_account(self.email)
    self.bitcoin_address = account[:address]
    self.account_id = account[:account_id]
    self.save
  end
end

class BtcAccount

  ADDRESS = "SWOLE-PRIMARY".freeze

  def self.primary_account
    BtcClient.get.primary_account
  end

  def self.swole_btc_address
    primary_account.addresses.select{|address| address["name"] == ADDRESS}.first["address"]
  end

  def self.btc_account_by_id(id)
    BtcClient.get.account(id)
  end

  def self.create_account(email)
    account = BtcClient.get.create_account(name: email)
    account.create_address
    {account_id: account.id, address: account.addresses.first["address"]}
  end

end

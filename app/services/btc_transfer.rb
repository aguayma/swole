class BtcTransfer

  def self.reward_user(user, amount)
    btc = CurrencyConverter.satoshi_to_btc(amount.to_s)
    BtcAccount.primary_account.send(to: user.bitcoin_address, amount: btc.to_s , currency: "BTC", description: "Payment")
  end

  def self.penalize_user(user, amount)
    btc = CurrencyConverter.satoshi_to_btc(amount.to_s)
    account = BtcAccount.btc_account_by_id(user.account_id)
    account.send(to: BtcAccount.swole_btc_address, amount: btc.to_s , currency: "BTC", description: "Payment")
  end

end
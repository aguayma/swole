class CurrencyConverter

  def self.usd_to_btc(amount)
    amount.to_f / buy_price rescue nil
  end

  def self.usd_to_satoshi(amount)
    btc_to_satoshi(amount.to_f / buy_price) rescue nil
  end

  def self.satoshi_to_btc(amount)
    if amount.length <= 8
      (8 - amount.length).times do |i|
        amount.prepend('0')
      end
      amount.prepend('.')
    else
      position = amount.length - 8
      amount.insert(position, '.')
    end
  end

  def self.satoshi_to_usd(amount)
    btc_to_usd(satoshi_to_btc(amount))
  end

  def self.btc_to_satoshi(amount)
    amount.to_f * 100000000
  end

  def self.btc_to_usd(amount)
    buy_price * amount.to_f
  end

  def self.buy_price
    @@buy_price ||= BtcClient.get.buy_price.amount.to_f
  end
end
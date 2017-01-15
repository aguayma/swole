class ProductController < ApplicationController
  before_action :grab_product, only: [:buy, :show]

  # index
  def index
    @products = Product.all
  end
  # show
  def show
  end

  def buy
    sat_price = CurrencyConverter.usd_to_satoshi(@product.price)
    if BtcAccount.get_balance_for_user(current_user).to_i >= sat_price
      BtcTransfer.penalize_user(current_user, sat_price)
      Purchase.create(user_id: current_user.id, amount: sat_price.to_i)
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  private

  def grab_product
    @product = Product.find(params[:id])
  end
end

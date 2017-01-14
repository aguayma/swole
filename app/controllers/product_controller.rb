class ProductController < ApplicationController
  before_action :grab_product, only: [:buy]

  # index
  def index
    @products = Product.all
  end
  # show


  def buy
    if BtcAccount.get_balance_for(current_user).to_i >= @product.price
      BtcTransfer.penalize_user(current_user, @product.price)
      # TODO: redirect to a purchaced page

    else
      # TODO: redirect to a page that informs the user he doesnt have enough balance

    end
  end

  private

  def grab_product
    @product = Product.find(params[:id])
  end
end

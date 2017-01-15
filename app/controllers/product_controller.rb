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
    if BtcAccount.get_balance_for_user(current_user).to_i >= @product.price
      BtcTransfer.penalize_user(current_user, @product.price)
      redirect_to root_path
      Purchase.create(user_id: current_user.id, amount: @product.price.to_i)
    else
      redirect_to :back
    end
  end

  private

  def grab_product
    @product = Product.find(params[:id])
  end
end

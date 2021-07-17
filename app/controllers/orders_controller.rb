class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :ensure_user_logged_in

  def index
    cart = current_user.cart
    @cart_items = CartItem.where("cart_id = ?", cart)
    render "index"
  end

  def create
    order = Order.new(
      date: Date.today,
      user_id: current_user.id,
      delivered_at: nil,
    )
    if order.save
      redirect_to "/order_items/#{order.id}/order"
    end
  end

  def update
    id = params[:id]
    order = Order.find(id)
    order.delivered_at = DateTime.now
    order.save
    flash[:error] = "Hey, Your order has been updated"
    redirect_to "/order_items"
  end
end

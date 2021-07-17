class OrderItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :ensure_user_logged_in

  def index
    if current_user.role == "customer"
      @orders = OrderItem.where("order_id IN (?)", current_user.orders.ids)
      render "index"
    end
    if current_user.role == "owner"
      @orders = OrderItem.all
      render "index"
    end
  end

  def order
    CartItem.all.each do |item|
      order_item = OrderItem.new(
        order_id: params[:id],
        menu_item_id: item.menu_item_id,
        menu_item_name: item.menu_item_name,
        menu_item_price: item.menu_item_price,
        quantity: item.quantity,
        price: item.price,
      )
      order_item.save
    end
    if CartItem.all.count == CartItem.all.count
      flash[:error] = "Wohhoo !! Your Order has been placed!"
      logger.info "Order Successfully Placed.. "
      CartItem.where("cart_id = ?", current_user.cart).destroy_all
      redirect_to "/menu_categories"
    end
  end
end
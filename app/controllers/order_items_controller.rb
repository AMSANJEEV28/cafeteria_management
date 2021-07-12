class OrderItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :ensure_user_logged_in

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
      logger.info "Successfully placed order"
      CartItem.where("cart_id = ?", current_user.cart).destroy_all
      redirect_to "/menu_categories"
    end
  end
end
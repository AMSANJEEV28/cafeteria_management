class CartItemsController < ApplicationController
  def increment
    cart_item_id = params[:id]
    order_item = CartItem.find_by(menu_item_id: params[:id])
    order_item.quantity = order_item.quantity + 1
    order_item.save
    flash[:notice] = "+1 #{order_item.menu_item_name}"
    redirect_to menus_path
  end
end

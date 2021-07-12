class CartItemsController < ApplicationController
  def increment
    menu_item_id = params[:id]
    cart_item = CartItem.find_by(menu_item_id: params[:id])
    cart_item.quantity = cart_item.quantity + 1
    cart_item.price = cart_item.quantity * cart_item.menu_item_price
    cart_item.save
    redirect_to "/menu_categories"
  end

  def decrement
    menu_item_id = params[:id]
    cart_item = CartItem.find_by(menu_item_id: params[:id])
    if cart_item.quantity > 1
      cart_item.quantity = cart_item.quantity - 1
      cart_item.price = cart_item.quantity * cart_item.menu_item_price
      cart_item.save
      redirect_to "/menu_categories"
    else
      destroy
    end
  end

  def create
    menu_item = MenuItem.find(params[:id])
    cart_id = current_user.cart.id
    cart_item = CartItem.new(
      cart_id: cart_id,
      menu_item_id: menu_item.id,
      menu_item_name: menu_item.name,
      menu_item_price: menu_item.price,
      quantity: 1,
      price: menu_item.price,
    )
    if cart_item.save!
      redirect_to "/menu_categories"
    end
  end

  def destroy
    menu_item_id = params[:id]
    cart_item = CartItem.find_by(menu_item_id: params[:id])
    cart_item.destroy
    redirect_to "/menu_categories"
  end
end
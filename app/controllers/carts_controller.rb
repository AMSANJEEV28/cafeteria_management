class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def create
    user_id = current_user.id
    cart = Cart.new(
      date: Date.today,
      user_id: user_id,
    )
    if cart.save
      redirect_to "/menu_categories" and return
    end
  end
end

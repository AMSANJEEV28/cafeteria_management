class AdminsController < ApplicationController
  before_action :ensure_owner_logged_in

  def index
    render "index"
  end

  def all_orders
    @orders = Order.all.order(:id)
  end
end

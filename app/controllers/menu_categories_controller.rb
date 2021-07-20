class MenuCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :ensure_user_logged_in

  def index
    @category = MenuCategory.get_menu_names
    cart = current_user.cart
    @cart = current_user.cart
    @cart_items = CartItem.where("cart_id = ?", cart)
    render "index"
  end

  def new
  end

  def show
  end

  def create
    category_name = params[:category_name]
    new_category = MenuCategory.new(
      name: category_name,
    )
    if new_category.save
      redirect_to menu_categories_path
    end
  end

  def update
    id = params[:id]
    category_name = params[:category_name]
    category = MenuCategory.find(id)
    category.name = category_name
    category.save!
    render ""
  end
end

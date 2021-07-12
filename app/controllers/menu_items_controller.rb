class MenuItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      @menu_list = MenuCategory.all
      @menu_items = MenuItem
      render "index"
    end
  
    def new
      @menu_list = MenuCategory.get_name
    end
  
    def show
      @menu_list = MenuCategory.get_name
      menu_category_id = params[:menu_category_id]
      @menu_items = MenuItem.get_item_names(menu_category_id)
      item_id = params[:id]
      @item_values = MenuItem.get_item_values(item_id)

    end
  
    def create
      menu_category_id = params[:menu_category_id]
      menu_item_name = params[:name]
      menu_item_description = params[:description]
      menu_item_price = (params[:price].to_i) * 100
      new_menu_item = MenuItem.new(
        menu_category_id: menu_category_id,
        name: menu_item_name,
        description: menu_item_description,
        price: menu_item_price,
      )
      if new_menu_item.save
        redirect_to "/"
      end
    end
  
    def update
      menu_item_id = params[:id]
      menu_item_name = params[:name]
      menu_item_description = params[:description]
      menu_item_price = (params[:price].to_i) * 100
      item = MenuItem.find(menu_item_id)
      item.name = menu_item_name
      item.description = menu_item_description
      item.price = menu_item_price
      item.save!
      redirect_to "/menu_categories"
  
    end
  end
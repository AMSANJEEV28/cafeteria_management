class MenuItem < ApplicationRecord
  belongs_to :menu_category

  def self.get_items(id)
    where("menu_category_id = ?", id)
  end

  def self.get_item_names(id)
    where("menu_category_id = ?", id).pluck(:name, :id)
  end

  def self.get_item_values(menu_id)
    where("id = ?", menu_id).pluck(:name, :description, :price)
  end
end

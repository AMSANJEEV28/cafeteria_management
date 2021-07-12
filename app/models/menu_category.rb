class MenuCategory < ApplicationRecord
  has_many :menu_items

  def self.get_menu_names
    MenuCategory.all.map { |menu| menu }
  end

  def self.get_name
    MenuCategory.pluck(:name, :id)
  end

  def isActive?
    active
  end

  def makeActive
    MenuCategory.all.map { |menu|
      menu.active = false
      menu.save
    }
    menu = MenuCategory.find(:params[id])
    menu.active = true
    menu.save
    MenuCategory.all.map { |menu| puts "#{menu.name} #{menu.active}" }
  end
end

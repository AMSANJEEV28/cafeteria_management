class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.bigint :menu_category_id
      t.string :name
      t.text :about_item
      t.money :cost
      t.timestamps
    end
  end
end

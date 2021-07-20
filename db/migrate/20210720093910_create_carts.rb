class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.date "date"
      t.bigint "user_id"
      t.datetime "delivered_at"
      t.bigint "total_price"
      t.timestamps
    end
  end
end

class CreateDeliverOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :deliver_orders do |t|
      add_column :orders, :delivered_at, :datetime
      t.timestamps
    end
  end
end

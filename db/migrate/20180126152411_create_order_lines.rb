class CreateOrderLines < ActiveRecord::Migration[5.1]
  def change
    create_table :order_lines do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :qty
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end

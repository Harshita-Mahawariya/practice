class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :cart_item_price
      t.integer :cart_item_quantity
      t.belongs_to :cart
      t.references :product
      t.timestamps
    end
  end
end

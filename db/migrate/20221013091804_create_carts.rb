class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :cart_price
      t.integer :cart_quantity
      t.belongs_to :account
      t.timestamps
    end
  end
end

class CreateProductvariants < ActiveRecord::Migration[6.1]
  def change
    create_table :productvariants do |t|
      t.string :name
      t.string :place
      t.integer :price
      t.integer :stock_quantity

      t.timestamps
    end
  end
end

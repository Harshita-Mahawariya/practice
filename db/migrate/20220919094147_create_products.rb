class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.belongs_to :category, index: true, foreign_key:true
      t.string :name
      t.integer :price
      t.integer :quantity
      t.datetime :ordered_on
      t.timestamps
    end
  end
end

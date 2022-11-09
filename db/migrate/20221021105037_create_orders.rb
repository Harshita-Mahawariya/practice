class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key:true
      t.string :order_no
      t.string :status
      t.integer :amount
      t.datetime :ordered_on
      t.timestamps
    end
  end
end

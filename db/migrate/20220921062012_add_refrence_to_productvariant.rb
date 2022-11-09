class AddRefrenceToProductvariant < ActiveRecord::Migration[6.1]
  def change
    add_reference :productvariants, :product, null: false, foreign_key: true
    #add_foreign_key :product, :productvariants
  end
end

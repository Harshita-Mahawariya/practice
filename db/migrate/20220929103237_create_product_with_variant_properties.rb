class CreateProductWithVariantProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :product_with_variant_properties do |t|
      t.belongs_to :productvariant ,foreign_key: true
      t.belongs_to :variant_property ,foreign_key: true
      t.timestamps
    end
  end
end
class CreateVariantProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :variant_properties do |t|
      t.belongs_to :variant, foreign_key:true
      t.string :name
      t.timestamps
    end
  end
end

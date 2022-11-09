class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :house_no
      t.string :building_name
      t.string :area_or_colony
      t.integer :pincode
      t.string :city
      t.string :state
      t.string :near_by_location
      t.belongs_to :user, foreign_key:true
      t.timestamps
    end
  end
end

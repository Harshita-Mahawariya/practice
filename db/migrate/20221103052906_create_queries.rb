class CreateQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :queries do |t|
      t.string :description
      t.references :user
      t.references :product
      t.belongs_to :answer, foreign_key:{to_table: :queries}
      t.timestamps
    end
  end
end

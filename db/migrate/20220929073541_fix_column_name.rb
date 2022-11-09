class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :ordered_on, :date
  end
end

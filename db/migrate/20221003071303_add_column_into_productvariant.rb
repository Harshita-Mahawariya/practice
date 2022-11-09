class AddColumnIntoProductvariant < ActiveRecord::Migration[6.1]
  def change
    add_column :productvariants, :Description, :string
  end
end

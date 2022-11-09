class Addcolumntoaccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :uniquenumber, :string
    add_column :accounts, :passcode, :string
  end
end

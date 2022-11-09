class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :fullname
      t.integer :phoneno
      t.string :email
      t.string :password_digest
      t.string :place
      t.integer :countrycode
      t.string :country

      t.timestamps
    end
  end
end

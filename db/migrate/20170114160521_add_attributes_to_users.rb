class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bitcoin_address, :string
    add_column :users, :account_id, :string
    add_column :users, :name, :string
    add_column :users, :birthday, :string
    add_column :users, :auth_token, :string
  end
end

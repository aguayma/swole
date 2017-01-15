class AddPicUrlToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pic_url, :string
  end
end

class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end

class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.boolean :achieved
      t.integer :amount

      t.timestamps
    end
  end
end

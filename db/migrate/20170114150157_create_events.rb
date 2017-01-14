class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :event_type, foreign_key: true
      t.integer :coin_earned
      t.text :data

      t.timestamps
    end
  end
end

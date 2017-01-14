class CreateEventTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :event_types do |t|
      t.string :name
      t.string :code
      t.float :multiplier

      t.timestamps
    end
  end
end

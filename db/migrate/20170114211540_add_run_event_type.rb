class AddRunEventType < ActiveRecord::Migration[5.0]
  def change
    EventType.create!(name: "Running", code:"RUN", multiplier: 1)
  end
end

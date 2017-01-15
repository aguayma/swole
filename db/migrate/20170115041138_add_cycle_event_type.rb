class AddCycleEventType < ActiveRecord::Migration[5.0]
  def change
    EventType.create!(name: "Cycling", code:"CYC", multiplier: 1)
  end
end

class AddGoalToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :goal, foreign_key: true
  end
end

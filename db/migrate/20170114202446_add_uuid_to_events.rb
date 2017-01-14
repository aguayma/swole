class AddUuidToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :uuid, :string
  end
end

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :goal
  belongs_to :event_type

end

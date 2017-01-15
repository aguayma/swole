class Event < ApplicationRecord
  belongs_to :user
  belongs_to :goal, optional: true
  belongs_to :event_type

end

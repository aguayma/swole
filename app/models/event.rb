class Event < ApplicationRecord
  belongs_to :user
  has_one :event_type

  serialize :data
end

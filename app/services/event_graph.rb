class EventGraph

  def self.distance_graph(user)
    data = []
    user.events.each do |event|
      data << [event.event_date.to_date, event.data.to_f]
    end
    return [{name: 'miles', data: data}]
  end

end

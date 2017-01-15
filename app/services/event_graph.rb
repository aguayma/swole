class EventGraph

  def self.distance_graph(user)
    biking = []
    running = []
    user.events.each do |event|
      if event.event_type.code == "CYC"
        biking << [event.event_date.to_date, event.data.to_f]
      else
        running << [event.event_date.to_date, event.data.to_f]
      end
    end
    return [{name: 'BIKING', data: biking}, {name: 'RUNNING', data: running}]
  end

  def self.earnings_graph(user)
    data = []
    user.events.each do |event|
      event.goal
      data << [event.event_date.to_date, event.goal.amount]
    end
    return [{name: 'SATOSHI', data: data}]
  end

end

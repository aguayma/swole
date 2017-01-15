class EventGraph

  def self.running_graph(user)
    running = []
    user.events.each do |event|
      if event.event_type.code == "RUN"
        running << [event.event_date.to_date, event.data.to_f]
      end
    end
    return [{name: 'RUNNING', data: running}]
  end

  def self.biking_graph(user)
    biking = []
    user.events.each do |event|
      if event.event_type.code == "CYC"
        biking << [event.event_date.to_date, event.data.to_f]
      end
    end
    return [{name: 'BIKING', data: biking}]
  end

  def self.earnings_graph(user)
    data = []
    user.events.each do |event|
      if event.goal.achieved
        data << [event.event_date.to_date, event.goal.amount]
      else
        data << [event.event_date.to_date, -event.goal.amount]
      end
    end
    return [{name: 'SATOSHI', data: data}]
  end

end

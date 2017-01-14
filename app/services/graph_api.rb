class GraphAPI
  def self.get_seven_activity_items(user)
    HealthGraph::User.new(user.auth_token).fitness_activities.items.select{|item| item["start_time"].to_date >= (DateTime.now - 7.days).to_date }
  end
end

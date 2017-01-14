class GraphAPI
  def self.get_seven_activity_items(user)
    HealthGraph::User.new(user.auth_token).fitness_activities.items.select{|activity| activity['type'] == 'Running'}
  end
end

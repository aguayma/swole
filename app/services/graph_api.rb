class GraphAPI

  def self.get_running_activity_items(user)
    HealthGraph::User.new(user.auth_token).fitness_activities.items.select{|activity| activity['type'] == 'Running'}.sort_by{|activity| activity["start_time"].to_date}.reverse
  end

  def self.get_cycling_activity_items(user)
    HealthGraph::User.new(user.auth_token).fitness_activities.items.select{|activity| activity['type'] == 'Cycling'}.sort_by{|activity| activity["start_time"].to_date}.reverse
  end

  def self.get_rk_profile_pic(user)
    HealthGraph::User.new(user.auth_token).profile.body["normal_picture"]
  end
end

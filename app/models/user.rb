class User < ApplicationRecord
  has_many :events
  has_many :purchases
  after_create :connect_bitcoin_account
  after_create :get_profile_pic
  attr_accessor :activity_distance, :goal_distance, :baseline
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:runkeeper], :authentication_keys => [:uid]

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = "#{auth.uid}@runkeeper.com"
     user.password = Devise.friendly_token[0,20]
     user.birthday = auth.extra.raw_info.birthday
     user.name = auth.info.name
     user.auth_token = auth.credentials.token
   end
  end

  def connect_bitcoin_account
    account = BtcAccount.create_account(self.email)
    self.bitcoin_address = account[:address]
    self.account_id = account[:account_id]
    self.save
  end

  def calculate_balance
    balance = 0
    goals.each do |goal|
      if goal.achieved
        balance += goal.amount
      else
        balance -= goal.amount
      end
    end
    purchases.each{|purchase| balance -= purchase.amount}
    balance
  end

  def get_profile_pic
    self.pic_url = GraphAPI.get_rk_profile_pic(self)
    save!
  end

  def import_events
    import_running_events
    import_cycling_events
  end

  def import_running_events
    import_events_for_type(EventType.find_by_code('RUN').id, GraphAPI.get_running_activity_items(self))
  end

  def import_cycling_events
    import_events_for_type(EventType.find_by_code('CYC').id, GraphAPI.get_cycling_activity_items(self))
  end

  def next_goal
    next_run_goal
  end

  def next_run_goal
    calculate_next_goal(EventType.find_by_code('RUN').id)
  end

  def next_cycle_goal
    calculate_next_goal(EventType.find_by_code('CYC').id)
  end


  def goals
    events.map(&:goal).compact
  end

  private

  def import_events_for_type(event_type_id, activities)
    current_events = Event.where(user_id: self.id).map(&:uuid)
    new_activities = activities.select{|activity| !current_events.include?(activity['uri'][19..27])}
    new_activities.each do |activity|
      events = Event.where(user_id: self.id).where(event_type_id: event_type_id)
      total_distance = events.map{|event| event.data.to_f}.inject(:+)
      @baseline = total_distance ?  total_distance / events.length : 1
      @goal_distance = baseline * 1.1
      @activity_distance = activity["total_distance"] * 0.000621371
      goal = nil
      if paid
        goal = Goal.create!(goal_hash)
        if goal.achieved
          BtcTransfer.reward_user(self, goal.amount)
        elsif goal.amount > 0
          balance = BtcAccount.get_balance_for_user(self).to_i
          penalty = goal.amount < balance ? goal.amount : balance
          BtcTransfer.penalize_user(self, penalty)
        end
      end      
      Event.create!(user_id: self.id, event_type_id: event_type_id, data: "#{activity_distance}", goal_id: goal.try(:id), uuid: activity['uri'][19..27], event_date: activity.start_time)
    end
  end

  def calculate_next_goal(event_type_id)
    events = Event.where(user_id: self.id).where(event_type_id: event_type_id)
    total_distance = events.map{|event| event.data.to_f}.inject(:+)
    baseline = total_distance ?  total_distance / events.length : 1
    (baseline * 1.1).round(2)
  end

  def goal_hash
    if activity_distance > goal_distance
      {achieved: true, amount: bonus_amount}
    elsif activity_distance > (baseline * 0.75)
      {achieved: false, amount: 0}
    else
      {achieved: false, amount: 120000}
    end
  end

  def bonus_amount
    difference = activity_distance - goal_distance
    percent_above_goal = difference / baseline
    multiplier = percent_above_goal + 1
    bonus = multiplier > 1.5 ? 1.5 : multiplier
    120000 * bonus
  end
end

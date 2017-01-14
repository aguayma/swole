class User < ApplicationRecord
  has_many :events
  # after_create :connect_bitcoin_account
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

  def import_events
    activities = GraphAPI.get_seven_activity_items(self)
    current_events = events.map(&:uuid)
    new_activities = activities.select{|activity| !current_events.include?(activity['uri'][19..27])}
    new_activities.each do |activity|
      events = Event.where(user_id: self.id)
      total_distance = events.map{|event| event.data.to_f}.inject(:+)
      @baseline = total_distance ?  total_distance / events.length : 1
      @goal_distance = baseline * 1.1
      @activity_distance = activity["total_distance"] * 0.000621371
      goal = Goal.create!(goal_hash)
      if goal.achieved
        BtcTransfer.reward_user(self, goal.amount)
      else
        balance = BtcAccount.get_balance_for_user(self).to_i
        penalty = goal.amount < balance ? goal.amount : balance
        BtcTransfer.penalize_user(self, penalty)
      end
      event_type_id = EventType.find_by_code("RUN").id
      Event.create!(user_id: self.id, event_type_id: event_type_id, data: "#{activity_distance}", goal_id: goal.id, uuid: activity['uri'][19..27])
    end
  end

  private

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

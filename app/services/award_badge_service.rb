class AwardBadgeService
  def initialize(user)
    @user = user
  end

  def call
    total_hours = calculate_total_hours
    check_and_award_badges(total_hours)
  end

  private

  def calculate_total_hours
    # Sum duration of all completed trainings (End Time - Start Time) in hours
    # This is an approximation. Ideally we store duration in Training.
    completed_trainings = @user.trainings.joins(:enrollments).where(enrollments: { status: :completed })
    
    total_seconds = completed_trainings.sum do |t|
      (t.end_time - t.start_time).to_i
    end

    (total_seconds / 3600.0).round
  end

  def check_and_award_badges(hours)
    award(:silver) if hours >= 25
    award(:gold) if hours >= 50
    award(:platinum) if hours >= 100
  end

  def award(level_sym)
    badge = Badge.find_by(level: level_sym)
    return unless badge
    
    unless @user.badges.exists?(id: badge.id)
      UserBadge.create(user: @user, badge: badge, awarded_at: Time.current)
    end
  end
end

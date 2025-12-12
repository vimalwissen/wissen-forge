class DashboardController < ApplicationController
  def index
    @trainings = policy_scope(Training).upcoming.limit(5)
    @my_enrollments = current_user.enrollments.includes(:training).limit(5)
    
    # Mandatory trainings the user needs to complete (enrolled but not completed)
    @mandatory_trainings = current_user.enrollments
      .joins(:training)
      .where(trainings: { training_type: :mandatory })
      .where.not(status: :completed)
      .includes(:training)
    
    # Only Super Admin can see and approve pending trainings
    if current_user.super_admin?
      @pending_approvals = Training.where(status: :pending_approval).count
    else
      @pending_approvals = 0
    end
  end
end

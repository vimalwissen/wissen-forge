class DashboardController < ApplicationController
  def index
    @trainings = policy_scope(Training).upcoming.limit(5)
    @my_enrollments = current_user.enrollments.includes(:training).limit(5)
    
    if current_user.admin? || current_user.super_admin?
      @pending_approvals = Training.where(status: :pending_approval).count
    end
  end
end

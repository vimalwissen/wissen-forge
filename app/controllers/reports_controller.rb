class ReportsController < ApplicationController
  def index
    # Ensure only managers can access
    unless current_user.subordinates.any? || current_user.admin? || current_user.super_admin?
      redirect_to root_path, alert: "Access denied."
      return
    end

    @reportees = if current_user.admin? || current_user.super_admin?
                   User.where.not(id: current_user.id)
                 else
                   current_user.subordinates
                 end
                 
    @completion_stats = @reportees.map do |user|
      {
        user: user,
        total_trainings: user.enrollments.count,
        completed: user.enrollments.completed.count,
        mandatory_pending: user.enrollments.joins(:training).where(trainings: { mode: :mandatory }, status: [:enrolled, :waitlisted]).count
      }
    end
  end
end

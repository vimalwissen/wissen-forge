class ReportsController < ApplicationController
  def index
    # Ensure only managers/admins can access
    unless current_user.subordinates.any? || current_user.admin? || current_user.super_admin?
      redirect_to root_path, alert: "Access denied."
      return
    end

    @report_type = params[:type] || "team"
    
    case @report_type
    when "team"
      load_team_report
    when "department"
      load_department_report
    when "mandatory"
      load_mandatory_report
    else
      load_team_report
    end
  end

  private

  def load_team_report
    @reportees = if current_user.admin? || current_user.super_admin?
                   User.where.not(id: current_user.id)
                 else
                   current_user.subordinates
                 end
                 
    @completion_stats = @reportees.map do |user|
      mandatory_enrolled = user.enrollments.joins(:training).where(trainings: { mode: :mandatory })
      {
        user: user,
        total_trainings: user.enrollments.count,
        completed: user.enrollments.completed.count,
        mandatory_total: mandatory_enrolled.count,
        mandatory_completed: mandatory_enrolled.completed.count,
        mandatory_pending: mandatory_enrolled.where.not(status: :completed).count
      }
    end
  end

  def load_department_report
    @departments = User.distinct.pluck(:department).compact
    @department_stats = @departments.map do |dept|
      users = User.where(department: dept)
      enrollments = Enrollment.where(user: users)
      mandatory_enrollments = enrollments.joins(:training).where(trainings: { mode: :mandatory })
      
      {
        department: dept,
        total_employees: users.count,
        total_enrollments: enrollments.count,
        completed: enrollments.completed.count,
        completion_rate: enrollments.count > 0 ? ((enrollments.completed.count.to_f / enrollments.count) * 100).round(1) : 0,
        mandatory_compliance: mandatory_enrollments.count > 0 ? ((mandatory_enrollments.completed.count.to_f / mandatory_enrollments.count) * 100).round(1) : 100
      }
    end
  end

  def load_mandatory_report
    @mandatory_trainings = Training.mandatory.published
    @training_stats = @mandatory_trainings.map do |training|
      enrollments = training.enrollments
      {
        training: training,
        total_assigned: enrollments.count,
        completed: enrollments.completed.count,
        pending: enrollments.where.not(status: :completed).count,
        completion_rate: enrollments.count > 0 ? ((enrollments.completed.count.to_f / enrollments.count) * 100).round(1) : 0
      }
    end
  end
end

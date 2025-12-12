class TrainingPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || user.super_admin?
  end

  def update?
    user.admin? || user.super_admin?
  end

  def destroy?
    user.super_admin?
  end

  # Special action for mandatory approval
  def approve?
    user.super_admin?
  end

  def publish?
    if record.mandatory?
      user.super_admin? && record.status == "pending_approval"
    else
      user.admin? || user.super_admin?
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.super_admin?
        scope.all
      else
        # All employees can see all published trainings
        scope.published.or(scope.where(id: user.training_ids))
      end
    end
  end
end

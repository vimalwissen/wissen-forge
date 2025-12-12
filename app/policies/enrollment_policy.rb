class EnrollmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || user.super_admin? || record.user_id == user.id || user.subordinates.include?(record.user)
  end

  def create?
    # Anyone can enroll if training is open (handled in controller logic usually, or here)
    true
  end

  def update?
    user.admin? || user.super_admin?
  end

  def destroy?
    # Cancel enrollment
    user.admin? || user.super_admin? || record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.super_admin?
        scope.all
      elsif user.manager_id.present? || user.subordinates.any?
        # Managers see their own and their subordinates' enrollments
        scope.where(user_id: [user.id] + user.subordinate_ids)
      else
        scope.where(user_id: user.id)
      end
    end
  end
end

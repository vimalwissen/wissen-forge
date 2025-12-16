class Training < ApplicationRecord
  enum :training_type, { classroom: 0, online: 1 }
  enum :mode, { mandatory: 0, optional: 1 }
  enum :status, { pending_approval: 0, published: 1, archived: 2 }, default: :pending_approval
  enum :assignment_scope, { assign_all: 0, assign_department: 1, assign_specific: 2 }, default: :assign_all

  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_one :quiz, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :lessons, -> { order(:position) }, dependent: :destroy

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :capacity, numericality: { greater_than: 0 }, if: -> { classroom? }
  # Skills are optional but stored as array


  scope :published, -> { where(status: :published) }
  scope :mandatory, -> { where(mode: :mandatory) }
  scope :upcoming, -> { where("start_time > ?", Time.current) }

  # Check if training is visible to a specific user based on assignment scope
  def visible_to?(user)
    return true if assign_all?
    return target_departments.include?(user.department) if assign_department?
    return target_user_ids.include?(user.id) if assign_specific?
    false
  end

  # Scope to get trainings visible to a user
  def self.visible_to_user(user)
    all_scope = where(assignment_scope: :assign_all)
    dept_scope = where(assignment_scope: :assign_department).where("? = ANY(target_departments)", user.department)
    specific_scope = where(assignment_scope: :assign_specific).where("? = ANY(target_user_ids)", user.id)
    
    all_scope.or(dept_scope).or(specific_scope)
  end
end


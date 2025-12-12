class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :training

  enum :status, { enrolled: 0, completed: 1, cancelled: 2, waitlisted: 3 }, default: :enrolled

  validates :user_id, uniqueness: { scope: :training_id, message: "is already enrolled" }
  validate :check_capacity, on: :create

  private

  def check_capacity
    return unless training
    return unless training.classroom?
    if training.enrollments.count >= training.capacity
      self.status = :waitlisted
    end
  end
end

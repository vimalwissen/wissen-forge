class LessonProgress < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :user_id, uniqueness: { scope: :lesson_id, message: "has already started this lesson" }

  scope :completed, -> { where(completed: true) }

  def mark_complete!
    update!(completed: true, completed_at: Time.current)
  end
end

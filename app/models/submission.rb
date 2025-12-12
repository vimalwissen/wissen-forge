class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :assignment

  validates :file_url, presence: true
  validates :user_id, uniqueness: { scope: :assignment_id, message: "has already submitted" }

  scope :graded, -> { where.not(grade: nil) }
end

class Training < ApplicationRecord
  enum :training_type, { classroom: 0, online: 1 }
  enum :mode, { mandatory: 0, optional: 1 }
  enum :status, { pending_approval: 0, published: 1, archived: 2 }, default: :pending_approval

  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_one :quiz, dependent: :destroy
  has_many :assignments, dependent: :destroy

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :capacity, numericality: { greater_than: 0 }, if: -> { classroom? }

  scope :published, -> { where(status: :published) }
  scope :mandatory, -> { where(mode: :mandatory) }
  scope :upcoming, -> { where("start_time > ?", Time.current) }
end

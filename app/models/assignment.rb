class Assignment < ApplicationRecord
  belongs_to :training
  has_many :submissions, dependent: :destroy

  validates :title, presence: true
  validates :due_date, presence: true
end

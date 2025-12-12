class Quiz < ApplicationRecord
  belongs_to :training

  validates :questions, presence: true
  # questions stored as JSONB: [{ question: "...", options: ["a", "b"], correct: "a" }]
end

class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  enum :level, { silver: 0, gold: 1, platinum: 2 }

  validates :name, presence: true, uniqueness: true
end

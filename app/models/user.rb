class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { employee: 0, admin: 1, super_admin: 2 }, default: :employee

  belongs_to :manager, class_name: "User", optional: true
  has_many :subordinates, class_name: "User", foreign_key: "manager_id"
  has_many :enrollments, dependent: :destroy
  has_many :trainings, through: :enrollments
  has_many :submissions, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  validates :name, presence: true
  validates :role, presence: true

  def acquired_skills
    # Get all training IDs where enrollment is completed
    completed_training_ids = enrollments.completed.pluck(:training_id)
    
    # Fetch skills from those trainings
    Training.where(id: completed_training_ids)
            .pluck(:skills)
            .flatten
            .compact
            .reject(&:blank?)
            .uniq
  end
end

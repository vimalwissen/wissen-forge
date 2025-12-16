class Lesson < ApplicationRecord
  belongs_to :training
  has_many :lesson_progresses, dependent: :destroy

  validates :title, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }

  def completed_by?(user)
    lesson_progresses.exists?(user: user, completed: true)
  end

  def youtube_embed_url
    return nil unless video_url.present?
    
    # Convert YouTube watch URL to embed URL
    if video_url.include?("youtube.com/watch")
      video_id = video_url.split("v=").last.split("&").first
      "https://www.youtube.com/embed/#{video_id}"
    elsif video_url.include?("youtu.be/")
      video_id = video_url.split("youtu.be/").last.split("?").first
      "https://www.youtube.com/embed/#{video_id}"
    else
      video_url # Assume it's already an embed URL
    end
  end
end

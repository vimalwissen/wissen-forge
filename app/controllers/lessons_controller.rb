class LessonsController < ApplicationController
  before_action :set_training
  before_action :set_lesson, only: [:show, :complete]

  def show
    @enrollment = current_user.enrollments.find_by(training: @training)
    @progress = current_user.lesson_progresses.find_by(lesson: @lesson)
    @previous_lesson = @training.lessons.where("position < ?", @lesson.position).order(position: :desc).first
    @next_lesson = @training.lessons.where("position > ?", @lesson.position).order(:position).first
  end

  def complete
    @progress = current_user.lesson_progresses.find_or_initialize_by(lesson: @lesson)
    
    if @progress.mark_complete!
      # Check if all lessons are completed for this training
      total_lessons = @training.lessons.count
      completed_lessons = current_user.lesson_progresses
        .joins(:lesson)
        .where(lessons: { training_id: @training.id }, completed: true)
        .count

      if completed_lessons >= total_lessons
        # Mark enrollment as completed
        enrollment = current_user.enrollments.find_by(training: @training)
        if enrollment && !enrollment.completed?
          enrollment.update(status: :completed, completion_date: Time.current)
        end
      end

      redirect_to training_lesson_path(@training, @lesson), notice: "Lesson marked as complete! 🎉"
    else
      redirect_to training_lesson_path(@training, @lesson), alert: "Could not mark lesson as complete."
    end
  end

  private

  def set_training
    @training = Training.find(params[:training_id])
  end

  def set_lesson
    @lesson = @training.lessons.find(params[:id])
  end
end

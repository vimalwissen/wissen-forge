class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:update]

  def create
    @training = Training.find(params[:training_id])
    @enrollment = @training.enrollments.new(user: current_user)
    authorize @enrollment

    if @enrollment.save
      redirect_to @training, notice: "You have successfully enrolled."
    else
      redirect_to @training, alert: @enrollment.errors.full_messages.to_sentence
    end
  end

  def update
    authorize @enrollment
    if @enrollment.update(enrollment_params)
      if @enrollment.completed?
        AwardBadgeService.new(current_user).call
      end
      redirect_back fallback_location: root_path, notice: "Enrollment updated."
    else
      redirect_back fallback_location: root_path, alert: "Could not update enrollment."
    end
  end

  private
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:status, :attendance, :score)
    end
end

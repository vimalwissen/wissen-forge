class AssignmentsController < ApplicationController
  def index
    @training = Training.find(params[:training_id])
    @assignments = @training.assignments
    authorize @assignments
  end

  def show
    @training = Training.find(params[:training_id])
    @assignment = @training.assignments.find(params[:id])
    authorize @assignment
    @my_submission = @assignment.submissions.find_by(user: current_user)
  end
end

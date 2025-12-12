class AssignmentsController < ApplicationController
  def index
    @training = Training.find(params[:training_id])
    @assignments = @training.assignments
    authorize @assignments
  end

  def show
    @assignment = Assignment.find(params[:id])
    authorize @assignment
    @submission = @assignment.submissions.find_by(user: current_user) || @assignment.submissions.new
  end
end

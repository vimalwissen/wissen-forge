class SubmissionsController < ApplicationController
  def create
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.new(submission_params)
    @submission.user = current_user
    # authorize @submission # TODO: Create SubmissionPolicy

    if @submission.save
      redirect_to @assignment, notice: "Assignment submitted successfully."
    else
      redirect_to @assignment, alert: "Failed to submit assignment."
    end
  end

  private
    def submission_params
      params.require(:submission).permit(:file_url)
    end
end

require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  let(:training) { create(:training) }
  let(:assignment) { create(:assignment, training: training) }
  let(:user) { create(:user) }

  before do
    sign_in user
    # User needs enrollment? Usually yes for authorization or logic
    create(:enrollment, user: user, training: training)
  end

  describe "POST #create" do
    let(:valid_attributes) {
      { file_url: "http://example.com/file.pdf" }
    }

    it "creates a new Submission" do
      expect {
        post :create, params: { 
          training_id: training.id, 
          assignment_id: assignment.id, 
          submission: valid_attributes 
        }
      }.to change(Submission, :count).by(1)
    end
  end
end

require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:training) { create(:training) }
  let(:user) { create(:user) }
  let(:enrollment) { create(:enrollment, user: user, training: training) }

  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a new Enrollment" do
      new_training = create(:training)
      expect {
        post :create, params: { training_id: new_training.id }
      }.to change(Enrollment, :count).by(1)
    end
  end

  describe "PATCH #update" do
    it "updates the enrollment status" do
      patch :update, params: { training_id: training.id, id: enrollment.id, enrollment: { status: 'completed' } }
      enrollment.reload
      expect(enrollment.status).to eq('completed')
    end
  end
end

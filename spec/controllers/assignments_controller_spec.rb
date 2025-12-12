require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  let(:training) { create(:training) }
  let(:assignment) { create(:assignment, training: training) }
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  describe "GET #index" do
    context "as a user" do
      before { sign_in user }
      it "returns a success response" do
        get :index, params: { training_id: training.id }
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    before { sign_in user }
    it "returns a success response" do
      get :show, params: { training_id: training.id, id: assignment.id }
      expect(response).to be_successful
    end
  end
end

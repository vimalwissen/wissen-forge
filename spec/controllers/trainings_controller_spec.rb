require 'rails_helper'

RSpec.describe TrainingsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:training) { create(:training) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: training.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: training.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Training" do
        expect {
          post :create, params: { training: attributes_for(:training) }
        }.to change(Training, :count).by(1)
      end

      it "redirects to the created training" do
        post :create, params: { training: attributes_for(:training) }
        expect(response).to redirect_to(Training.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { training: attributes_for(:training, title: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    
    context "with auto-enrollment" do
      it "enrolls target users" do
        target_user = create(:user)
        expect {
          post :create, params: { 
            training: attributes_for(:training, assignment_scope: :assign_specific, target_user_ids: [target_user.id]) 
          }
        }.to change(Enrollment, :count).by(1)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: "New Title" }
      }

      it "updates the requested training" do
        put :update, params: { id: training.to_param, training: new_attributes }
        training.reload
        expect(training.title).to eq("New Title")
      end

      it "redirects to the training" do
        put :update, params: { id: training.to_param, training: new_attributes }
        expect(response).to redirect_to(training)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: training.to_param, training: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "PATCH #publish" do
    it "updates status to published" do
      pending_training = create(:training, :pending)
      # Admin can't publish pending mandatory, so use non-mandatory or super admin
      # Let's test non-mandatory flow for admin
      pending_optional = create(:training, status: :pending_approval, mode: :optional)
      
      patch :publish, params: { id: pending_optional.to_param }
      pending_optional.reload
      expect(pending_optional.status).to eq("published")
    end
  end
end

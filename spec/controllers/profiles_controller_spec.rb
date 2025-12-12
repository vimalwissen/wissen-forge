require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #show" do
    context "for current user" do
      # Note: Route is resource :profile, so it maps to profiles#show without ID
      # BUT we also added resources :users, controller: 'profiles'
      
      it "returns a success response for /profile" do
        # This usually maps to params: {} if route is correct
        get :show
        expect(response).to be_successful
      end
    end

    context "for other user" do
      let(:other_user) { create(:user) }
      let(:admin) { create(:user, :admin) }

      it "returns success for admin viewing other profile" do
        sign_in admin
        get :show, params: { id: other_user.id }
        expect(response).to be_successful
      end
    end
  end
end

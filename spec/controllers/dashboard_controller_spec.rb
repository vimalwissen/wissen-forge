require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #index" do
    context "as a user" do
      before { sign_in create(:user) }
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end

    context "as an admin" do
      before { sign_in create(:user, :admin) }
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end
  end
end

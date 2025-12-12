require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:manager) { create(:user, designation: "Manager") }
  let(:admin) { create(:user, :admin) }

  describe "GET #index" do
    context "as admin" do
      before { sign_in admin }
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end

    context "as manager" do
      before { sign_in manager }
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end
  end
end

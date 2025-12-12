require 'rails_helper'

RSpec.describe "Trainings Filters", type: :request do
  let(:user) { create(:user) }
  let!(:react_training) { create(:training, title: "React Basics", skills: ["React"], training_type: :online, mode: :optional, status: :published) }
  let!(:java_training) { create(:training, title: "Java Basics", skills: ["Java"], training_type: :classroom, mode: :mandatory, status: :published) }

  before do
    sign_in user
  end

  describe "GET /trainings" do
    it "returns successful response without filters" do
      get trainings_path
      expect(response).to have_http_status(:success)
    end

    it "filters by skill" do
      get trainings_path, params: { skill: "React" }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("React Basics")
      expect(response.body).not_to include("Java Basics")
    end

    it "filters by training_type" do
      get trainings_path, params: { training_type: "classroom" }
      expect(response).to have_http_status(:success)
      expect(response.body).not_to include("React Basics")
      expect(response.body).include("Java Basics")
    end

    it "filters by mode" do
      get trainings_path, params: { mode: "mandatory" }
      expect(response).to have_http_status(:success)
      expect(response.body).not_to include("React Basics")
      expect(response.body).include("Java Basics")
    end

    it "handles clear filters (redirects or render)" do
      # Link is just trainings_path
      get trainings_path
      expect(response).to have_http_status(:success)
    end
  end
end

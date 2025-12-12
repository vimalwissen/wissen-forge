require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:file_url) }
    
    it 'validates uniqueness of user scoped to assignment' do
      create(:submission)
      should validate_uniqueness_of(:user_id).scoped_to(:assignment_id).with_message("has already submitted")
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:assignment) }
  end

  describe 'scopes' do
    it 'returns graded submissions' do
      graded = create(:submission, :graded)
      ungraded = create(:submission, grade: nil)
      
      expect(Submission.graded).to include(graded)
      expect(Submission.graded).not_to include(ungraded)
    end
  end
end

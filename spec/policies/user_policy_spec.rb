require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  permissions :show_profile? do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    it 'allows user to see their own profile' do
      expect(subject).to permit(user, user)
    end

    it 'allows admin to see any profile' do
      expect(subject).to permit(admin, other_user)
    end

    it 'denies user from seeing other profiles' do
      expect(subject).not_to permit(user, other_user)
    end
    
    # Add manager permissions test if implemented
  end
end

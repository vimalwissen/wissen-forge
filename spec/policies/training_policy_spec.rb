require 'rails_helper'

RSpec.describe TrainingPolicy, type: :policy do
  subject { described_class }

  permissions :index?, :show? do
    let(:user) { create(:user) }
    let(:training) { create(:training) }

    it 'allows access to everyone' do
      expect(subject).to permit(user, training)
    end
  end

  permissions :create?, :update? do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:super_admin) { create(:user, :super_admin) }
    let(:training) { create(:training) }

    it 'denies access to regular users' do
      expect(subject).not_to permit(user, training)
    end

    it 'allows access to admins' do
      expect(subject).to permit(admin, training)
    end

    it 'allows access to super admins' do
      expect(subject).to permit(super_admin, training)
    end
  end

  permissions :destroy?, :approve? do
    let(:admin) { create(:user, :admin) }
    let(:super_admin) { create(:user, :super_admin) }
    let(:training) { create(:training) }

    it 'denies access to admins' do
      expect(subject).not_to permit(admin, training)
    end

    it 'allows access to super admins' do
      expect(subject).to permit(super_admin, training)
    end
  end

  permissions :publish? do
    let(:admin) { create(:user, :admin) }
    let(:super_admin) { create(:user, :super_admin) }
    
    it 'allows admin to publish non-mandatory training' do
      training = create(:training, mode: :optional)
      expect(subject).to permit(admin, training)
    end

    it 'denies admin from publishing mandatory training' do
      training = create(:training, status: :pending_approval, mode: :mandatory)
      expect(subject).not_to permit(admin, training)
    end

    it 'allows super admin to publish mandatory training' do
      training = create(:training, status: :pending_approval, mode: :mandatory)
      expect(subject).to permit(super_admin, training)
    end
  end
end

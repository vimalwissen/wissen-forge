require 'rails_helper'

RSpec.describe Training, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      training = build(:training)
      expect(training).to be_valid
    end

    it 'is invalid without a title' do
      training = build(:training, title: nil)
      expect(training).not_to be_valid
    end

    it 'is invalid without a start_time' do
      training = build(:training, start_time: nil)
      expect(training).not_to be_valid
    end

    it 'is invalid without an end_time' do
      training = build(:training, end_time: nil)
      expect(training).not_to be_valid
    end

    context 'when classroom training' do
      it 'validate capacity is positive' do
        training = build(:training, :classroom, capacity: 0)
        expect(training).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    describe '.published' do
      it 'returns only published trainings' do
        published = create(:training, status: :published)
        pending = create(:training, :pending)
        
        expect(Training.published).to include(published)
        expect(Training.published).not_to include(pending)
      end
    end

    describe '.visible_to_user' do
      let(:eng_user) { create(:user, department: 'Engineering') }
      let(:sales_user) { create(:user, department: 'Sales') }
      
      it 'shows trainings assigned to all' do
        training = create(:training, assignment_scope: :assign_all)
        expect(Training.visible_to_user(eng_user)).to include(training)
      end

      it 'shows trainings assigned to user department' do
        training = create(:training, assignment_scope: :assign_department, target_departments: ['Engineering'])
        expect(Training.visible_to_user(eng_user)).to include(training)
        expect(Training.visible_to_user(sales_user)).not_to include(training)
      end

      it 'shows trainings assigned specifically to user' do
        training = create(:training, assignment_scope: :assign_specific, target_user_ids: [eng_user.id])
        expect(Training.visible_to_user(eng_user)).to include(training)
        expect(Training.visible_to_user(sales_user)).not_to include(training)
      end
    end
  end

  describe '#visible_to?' do
    let(:user) { create(:user, department: 'Engineering') }

    it 'returns true for assign_all' do
      training = build(:training, assignment_scope: :assign_all)
      expect(training.visible_to?(user)).to be true
    end

    it 'returns true if user department matches' do
      training = build(:training, assignment_scope: :assign_department, target_departments: ['Engineering'])
      expect(training.visible_to?(user)).to be true
    end

    it 'returns false if user department does not match' do
      training = build(:training, assignment_scope: :assign_department, target_departments: ['Sales'])
      expect(training.visible_to?(user)).to be false
    end

    it 'returns true if user id matches' do
      training = build(:training, assignment_scope: :assign_specific, target_user_ids: [user.id])
      expect(training.visible_to?(user)).to be true
    end
  end
end

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      enrollment = build(:enrollment)
      expect(enrollment).to be_valid
    end

    it 'enforces uniqueness of user per training' do
      user = create(:user)
      training = create(:training)
      create(:enrollment, user: user, training: training)
      
      duplicate = build(:enrollment, user: user, training: training)
      expect(duplicate).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:training) }
  end
end

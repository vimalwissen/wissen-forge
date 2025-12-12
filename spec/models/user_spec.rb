require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end
    
    it 'is invalid without a role' do
      user = build(:user, role: nil)
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:trainings).through(:enrollments) }
    # Add other associations as needed
  end

  describe '#acquired_skills' do
    it 'returns skills from completed trainings' do
      user = create(:user)
      training1 = create(:training, skills: ['Ruby', 'Rails'])
      create(:enrollment, :completed, user: user, training: training1)
      
      training2 = create(:training, skills: ['React'])
      create(:enrollment, :completed, user: user, training: training2)
      
      # Incomplete training
      training3 = create(:training, skills: ['Python'])
      create(:enrollment, user: user, training: training3, status: :enrolled)

      skills = user.acquired_skills
      expect(skills).to include('Ruby', 'Rails', 'React')
      expect(skills).not_to include('Python')
      expect(skills.count).to eq(3)
    end

    it 'returns unique skills' do
      user = create(:user)
      training1 = create(:training, skills: ['Ruby'])
      create(:enrollment, :completed, user: user, training: training1)
      
      training2 = create(:training, skills: ['Ruby'])
      create(:enrollment, :completed, user: user, training: training2)

      expect(user.acquired_skills).to eq(['Ruby'])
    end
  end
end

require 'rails_helper'

RSpec.describe Badge, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    
    it 'validates uniqueness of name' do
      create(:badge)
      should validate_uniqueness_of(:name)
    end
  end

  describe 'associations' do
    it { should have_many(:user_badges).dependent(:destroy) }
    it { should have_many(:users).through(:user_badges) }
  end

  describe 'enums' do
    it { should define_enum_for(:level).with_values(silver: 0, gold: 1, platinum: 2) }
  end
end

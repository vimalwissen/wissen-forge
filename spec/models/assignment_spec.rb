require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:due_date) }
  end

  describe 'associations' do
    it { should belong_to(:training) }
    it { should have_many(:submissions).dependent(:destroy) }
  end
end

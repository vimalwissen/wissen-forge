require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:questions) }
  end

  describe 'associations' do
    it { should belong_to(:training) }
  end
end

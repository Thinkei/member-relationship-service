require 'spec_helper'

describe Organisation, type: :model do
  context 'name is empty' do
    let(:new_org) { Organisation.new(name: '') }

    it 'raises error' do
      expect(new_org.valid?).to be false
      expect(new_org.errors[:name].first).to eq('is not present')
    end
  end

  context 'name is not empty' do
    let(:new_org) { Organisation.new(name: 'org test') }

    it 'create a new org success' do
      expect(new_org.valid?).to be true
      expect(new_org.errors).to be_empty
    end
  end
end

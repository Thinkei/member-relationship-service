require 'spec_helper'

describe Group, type: :model do
  it { is_expected.to have_many_to_one :organisation }
  it { is_expected.to have_many_to_many :members }

  context 'organisation_id is empty' do
    let(:new_group) { Group.new(organisation_id: '') }

    it 'raises error' do
      expect(new_group.valid?).to be_falsey
      expect(new_group.errors[:organisation_id].first).to eq('is not present')
    end
  end

  context 'organisation_id is not empty' do
    let(:new_group) { Group.new(organisation_id: SecureRandom.uuid) }

    it 'create a new group success' do
      expect(new_group.valid?).to be_truthy
      expect(new_group.errors).to be_empty
    end
  end
end

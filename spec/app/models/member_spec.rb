require 'spec_helper'

describe Member, type: :model do
  it { is_expected.to have_many_to_one :organisation }

  context 'organisation_id is empty' do
    let(:new_member) { Member.new(organisation_id: '') }

    it 'raises error' do
      expect(new_member.valid?).to be false
      expect(new_member.errors[:organisation_id].first).to eq('is not present')
    end
  end

  context 'organisation_id is not empty' do
    let(:new_member) { Member.new(organisation_id: SecureRandom.uuid) }

    it 'create a new member success' do
      expect(new_member.valid?).to be true
      expect(new_member.errors).to be_empty
    end
  end
end

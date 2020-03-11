require 'spec_helper'

describe Organisation, type: :model do
  describe 'validation' do
    context 'name is empty' do
      let(:new_org) { Organisation.new(name: '') }

      it 'raises error' do
        expect(new_org.valid?).to be false
        expect(new_org.validate.first).to eq('cannot be empty')
      end
    end
  end
end

require 'spec_helper'

describe Member, type: :model do
  it { is_expected.to have_many_to_one :organisation }
  it { is_expected.to have_many_to_many :groups }
  it { is_expected.to have_many_to_many :teams }
  it { is_expected.to validate_presence :organisation_id }
end

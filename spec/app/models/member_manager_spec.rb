require 'spec_helper'

describe MemberManager, type: :model do
  it { is_expected.to have_many_to_one :member }
  it { is_expected.to validate_presence :manager_id }
  it { is_expected.to validate_presence :member_id }
  it { is_expected.to validate_unique %i[manager_id member_id] }
  it { is_expected.to validate_unique %i[member_id level] }
end

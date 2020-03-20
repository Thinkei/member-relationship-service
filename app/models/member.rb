class Member < Sequel::Model(DB[:members])
  many_to_one :organisation
  many_to_many :groups
  many_to_many :teams
  one_to_many :managers, class: :MemberManager, key: :manager_id
  one_to_many :members, class: :MemberManager, key: :member_id

  def validate
    super
    validates_presence [:organisation_id]
  end
end

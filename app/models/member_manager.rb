class MemberManager < Sequel::Model(DB[:member_managers])
  many_to_one :manager, class: :Member
  many_to_one :member

  def validate
    super
    validates_presence %i[manager_id member_id]
    validates_unique %i[manager_id member_id]
    validates_unique %i[member_id level]
  end
end

class Member < Sequel::Model(DB[:members])
  many_to_one :organisation
  many_to_many :groups

  def validate
    super
    validates_presence [:organisation_id]
  end
end

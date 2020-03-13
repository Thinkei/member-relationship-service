class Member < Sequel::Model(DB[:members])
  def validate
    super
    validates_presence [:organisation_id]
  end
end

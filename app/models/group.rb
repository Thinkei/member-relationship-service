class Group < Sequel::Model(DB[:groups])
  many_to_one :organisation
  many_to_many :members

  def validate
    super
    validates_presence [:organisation_id]
  end
end

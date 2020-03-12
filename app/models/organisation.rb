class Organisation < Sequel::Model(DB[:organisations])
  def validate
    super
    validates_presence [:name]
    validates_unique :name
  end
end

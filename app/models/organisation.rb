class Organisation < Sequel::Model(DB[:organisations])
  def validate
    super
    errors.add(:name, 'cannot be empty') if !name || name.empty?
  end
end

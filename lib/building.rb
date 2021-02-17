class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def average_rent
    rent_array = @units.map { |unit| unit.monthly_rent }
    total_amount = rent_array.inject(0) { |sum, rent| sum + rent }
    total_amount.to_f / @units.length
  end

  def renters
    units.map do |unit|
      unit.renter.name
    end
  end

  def add_unit(unit)
    @units << unit
  end

end

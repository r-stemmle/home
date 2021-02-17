class Building
  attr_reader :units

  def initialize
    @units = []
    @rented_units = []
  end

  def annual_breakdown
    breakdown = Hash.new { |hash, name| hash[name] = 0 }
    breakdown[rented_units.first.renter.name]= rented_units.first.monthly_rent * 12
    breakdown
  end

  def units_by_number_of_bedrooms
    units_hash = Hash.new { |hash, rooms| hash[rooms] = [] }
    units.each do |unit|
      units_hash[unit.bedrooms] << unit.number
    end
    units_hash
  end

  def renter_with_highest_rent
    highest = rented_units[-1].renter
    rented_units.sort_by do |unit|
      unit.monthly_rent
    end
    highest = rented_units[-1].renter
  end

  def average_rent
    rent_array = @units.map { |unit| unit.monthly_rent }
    total_amount = rent_array.inject(0) { |sum, rent| sum + rent }
    total_amount.to_f / @units.length
  end

  def rented_units
    @units.find_all do |unit|
      unit.renter != nil
    end
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

require 'minitest/autorun'
require 'minitest/pride'
require './lib/building'
require './lib/apartment'
require './lib/renter'

class BuildingTest < Minitest::Test
  def setup
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    @building = Building.new
    @renter1 = Renter.new("Aurora")
    @renter2 = Renter.new("Tim")
  end

  def test_it_exists
    building = Building.new

    assert_instance_of Building, building
  end

  def test_it_has_no_units_by_default
    building = Building.new

    assert_equal [], building.units
  end

  def test_it_can_add_and_have_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal [@unit1, @unit2], @building.units
  end

  def test_it_has_no_renters_by_default

    assert_equal [], @building.renters
  end

  def test_it_can_have_renters
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit1.add_renter(@renter1)
    @unit2.add_renter(@renter2)

    assert_equal ["Aurora", "Tim"], @building.renters
  end

  def test_it_can_find_average_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    
    assert_equal 1099.5, @building.average_rent
  end

end

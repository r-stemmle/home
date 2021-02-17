require 'minitest/autorun'
require 'minitest/pride'
require './lib/building'
require './lib/apartment'
require './lib/renter'

class BuildingTest < Minitest::Test
  def setup
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    @unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    @unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    @building = Building.new
    @renter1 = Renter.new("Spencer")
    @renter2 = Renter.new("Jessie")
    @renter3 = Renter.new("Max")
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

    assert_equal ["Spencer", "Jessie"], @building.renters
  end

  def test_it_can_find_average_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal 1099.5, @building.average_rent
  end

  def test_has_no_rented_units_by_default
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)

    assert_equal [], @building.rented_units
  end

  def test_it_can_have_rented_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)

    assert_equal [@unit2], @building.rented_units
  end

  def test_it_can_find_renter_with_highest_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)
    @unit3.add_renter(@renter3)

    assert_equal @renter3, @building.renter_with_highest_rent
  end

  def test_it_can_arrange_units_by_number_of_bedrooms
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)
    @unit3.add_renter(@renter3)
    @building.add_unit(@unit4)

    expected = { 3 => ["D4"],
                 2 => ["B2", "C3"],
                 1 => ["A1"]
               }

    assert_equal expected, @building.units_by_number_of_bedrooms
  end

  def test_it_can_find_rent_annual_breakdown
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)
    expected = {"Spencer" => 11988}

    assert_equal expected, @building.annual_breakdown
  end

  def test_it_can_find_rent_annual_breakdown_for_2
    skip #2nd to last item on iteration 4
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)
    @unit1.add_renter(@renter2)
    expected = {"Jessie" => 14400, "Spencer" => 11988}

    assert_equal expected, @building.annual_breakdown
  end

end

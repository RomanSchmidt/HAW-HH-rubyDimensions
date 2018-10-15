require 'test/unit'
require 'json'
require './mapping'

class RendererMockUp

end

class MappingMockUp < Mapping

end

class MappingTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @mapping = MappingMockUp.new(RendererMockUp.new)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # testing is the first_dimension and the second_dimension the same
  def test_get_transfer
    assert_equal({"constant"=>{"after"=>0, "before"=>0}, "multiplier"=>1}, @mapping.get_transfer('celsius', 'celsius'))
  end

  def test_get_transfer_cel_kelv
    assert_equal({"constant"=>{"after"=>0, "before"=>273.15}, "multiplier"=>1}, @mapping.get_transfer('celsius', 'kelvin'))
  end

  def test_get_transfer_nil
    assert_equal({"constant"=>{"after"=>0, "before"=>0}, "multiplier"=>1}, @mapping.get_transfer(nil , nil))
  end
end
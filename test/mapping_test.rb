require 'test/unit'
require 'json'
require './mapping'

class RendererMockUp
  def error_transfer_dimension(first_dimension, second_dimension = nil)

  end
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
    assert_equal({Mapping::CONSTANT_KEY => {Mapping::CONSTANT_AFTER_KEY => 0, Mapping::CONSTANT_BEFORE_KEY => 0}, Mapping::MULTIPLIER_KEY => 1}, @mapping.get_transfer('celsius', 'celsius'))
  end

  def test_get_transfer_cel_kelv
    assert_equal({Mapping::CONSTANT_KEY => {Mapping::CONSTANT_AFTER_KEY => 0, Mapping::CONSTANT_BEFORE_KEY => 273.15}, Mapping::MULTIPLIER_KEY => 1}, @mapping.get_transfer('celsius', 'kelvin'))
  end

  def test_get_transfer_nil
    assert_equal({Mapping::CONSTANT_KEY => {Mapping::CONSTANT_AFTER_KEY => 0, Mapping::CONSTANT_BEFORE_KEY => 0}, Mapping::MULTIPLIER_KEY => 1}, @mapping.get_transfer(nil, nil))
  end

  # make sure first value as 0 returns a nil
  def test_get_trans_err_int_f_para
    assert_nil(@mapping.get_transfer(0, 'celsius'))
  end

  # make sure second value as 0 returns a nil
  def test_get_trans_err_int_s_para
    assert_nil(@mapping.get_transfer('celsius', 0))
  end

  # make sure first value as nil returns a nil
  def test_get_trans_err_str_f_para
    assert_nil(@mapping.get_transfer('celsius', nil))
  end

  # make sure second value as nil returns a nil
  def test_get_trans_err_str_s_para
    assert_nil(@mapping.get_transfer(nil, 'celsius'))
  end
end
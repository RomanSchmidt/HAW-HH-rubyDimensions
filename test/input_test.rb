require 'test/unit'
require './input'
require './renderer'
require './converter'

class RendererMockUp < Renderer

  def print_get_single_value
  end

  def get_value_to_convert
  end
end

class ConverterMockUp < Converter
  #first_result = get_dimension(RendererMockUp::DIRECTION_IN)

  def get_dimension(direction)
    current_node = {ELEMENT_KEY => @mapping.get_categories, NAME_KEY => 'categories'}
  end
end

class InputMockUp < Input

  OUTPUT = 1.0

  def get_note_element
    node_element = [ConverterMockUp::ELEMENT_KEY]
  end

  def get_float
    OUTPUT
  end
end

class InputTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @input = InputMockUp.new(RendererMockUp.new)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # testing nil j case of dimension a int
  def test_get_node_element_int
    assert_nil(@input.get_node_element(1, Renderer::DIRECTION_IN))
  end

  # testing nil j case of dimension a float
  def test_get_node_element_float
    assert_nil(@input.get_node_element(1.0, Renderer::DIRECTION_IN))
  end

  # testing nil j case of dimension an array
  def test_get_node_element_arr
    assert_nil(@input.get_node_element([], Renderer::DIRECTION_IN))
  end

  # testing nil j case of dimension a nil
  def test_get_node_element_nil
    assert_nil(@input.get_node_element(nil, Renderer::DIRECTION_IN))
  end

  # testing nil j case of dimension a symbol
  def test_get_node_elmt_dimension
    assert_nil(@input.get_node_element(:foo, Renderer::DIRECTION_IN))
  end

  # testing success
  def test_get_node_element_success
    assert_nil(@input.get_node_element({'foo' => 'bar'}, Renderer::DIRECTION_IN), 'bar')
  end

  def test_get_dimension_int
    assert_nil(@input.get_node_element(Hash, 1))
  end

  def test_get_dimension_float
    assert_nil(@input.get_node_element(Hash, 1.0))
  end

  def test_get_dimension_arr
    assert_nil(@input.get_node_element(Hash, []))
  end

  def test_get_dimension_nil
    assert_nil(@input.get_node_element(Hash, nil))
  end

  def test_get_dimension_success
    assert_nil(@input.get_node_element(Hash, Renderer::DIRECTION_IN))
  end

  # make sure get_value is a float
  def test_get_value
    assert_equal(InputMockUp::OUTPUT, @input.get_value_to_convert)
  end
end
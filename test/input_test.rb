require 'test/unit'
require './input'
require './renderer'

class RendererMockUp < Renderer

  def print_get_single_value

  end
end

class InputMockUp < Input

  OUTPUT = 1.0

  def get_note_element
    node_element = [Converter::ELEMENT_PROPERTY]

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

  # testing if the note is a Hash
  def get_node_element_test_hash

  # testing if the note is a integer
  def get_node_element_test_int
    @input.get_node_element(ConverterMockUp.new.get_dimension, Renderer::DIRECTION_IN)
  end

  # testing if the note is a float
  def get_node_element_test_float

  end

  # testing if the note is a array
  def get_node_element_test_arr

  end

  # testing if the note is nil
  def get_node_element_test_nil

  end

  # testing if the dimension a symbol
  def get_node_element_test_dimension

  end

  # make sure its a float
  def test_get_value
    assert_equal(RendererMockUp::OUTPUT, @input.get_value)
  end
end
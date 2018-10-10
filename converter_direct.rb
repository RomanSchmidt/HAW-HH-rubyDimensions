require "./converter.rb"
require "./input_direct.rb"
require "./renderer_direct.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This Class handles the logical flow to get all parameters for a direct output.
class ConverterDirect < Converter
  private

  LAST_PROPERTY = 'leaf'
  SCALE_PROPERTY = 'scale'

  public

  # Initialize instance variables in the right order and make sure they get all parameters.
  # After all, start the script.
  def initialize
    super(RendererDirect.new, InputDirect.new)
    start
  end

  private

  # Flow for a inputs of single convert.
  # Recursion in case of failure.
  # Prints out a single line in the end.
  def start
    @renderer.print_first_dimension
    first_result = get_dimension(RendererDirect::DIRECTION_IN)
    first_dimension = first_result[LAST_PROPERTY]
    first_scale = first_result[SCALE_PROPERTY]
    @renderer.print_second_dimension
    second_result = get_dimension(RendererDirect::DIRECTION_OUT)
    second_dimension = second_result[LAST_PROPERTY]
    second_scale = second_result[SCALE_PROPERTY]
    value = @input.get_value

    convert(first_scale, first_dimension, second_scale, second_dimension, value)
  end

  def convert(first_scale, first_dimension, second_scale, second_dimension, value)
    calculated_value = get_value(first_scale, first_dimension, second_scale, second_dimension, value)
    @renderer.print_single_result(first_dimension, value, second_dimension, calculated_value)
  end

  # Running a loop as long as the current node is not a leaf.
  # Each loop is printing out the current node keys to select via input and go lower the three.
  # Returns a hash with the last property and its scale three.
  def get_dimension(direction)
    last_node = nil
    current_node = {ELEMENT_PROPERTY => @mapping.get_categories, NAME_PROPERTY => 'categories'}
    begin
      last_node = current_node
      current_node = get_next_node(current_node, direction)
    end while !current_node || current_node && current_node[ELEMENT_PROPERTY].fetch(LAST_PROPERTY, false) === false
    {LAST_PROPERTY => current_node[NAME_PROPERTY], SCALE_PROPERTY => last_node}
  end

  # Checking the current node is a leaf and return it or get the the next depth via input.
  def get_next_node(current_node, direction)
    if current_node && current_node[ELEMENT_PROPERTY][LAST_PROPERTY] === true
      current_node
    else
      @input.get_node_element(current_node, direction)
    end
  end
end
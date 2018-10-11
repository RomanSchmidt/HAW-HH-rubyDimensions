require './mapping.rb'
require './renderer.rb'

# Author: Roman Schmidt, Daniel Osterholz
#
# This class uses the Mapping class to get and handle the convert logic.
# It should not be initialized any time.
class Converter

  public

  NAME_PROPERTY = 'name'
  ELEMENT_PROPERTY = 'element'

  # make sure mapping is initialized
  def initialize(renderer, input, mapping)
    @renderer = renderer
    @input = input
    @mapping = mapping
    start
  end

  private

  # Flow for a inputs of single convert.
  # Recursion in case of failure.
  # Prints out a single line in the end.
  def start
    @renderer.print_first_dimension
    first_result = get_dimension(Renderer::DIRECTION_IN)
    first_dimension = first_result[Mapping::LAST_PROPERTY]
    first_scale = first_result[Mapping::SCALE_PROPERTY]
    @renderer.print_second_dimension
    second_result = get_dimension(Renderer::DIRECTION_OUT)
    second_dimension = second_result[Mapping::LAST_PROPERTY]
    second_scale = second_result[Mapping::SCALE_PROPERTY]
    value = @input.get_value

    convert(first_scale, first_dimension, second_scale, second_dimension, value)
  end

  # Get the value of the current category in the default dimension by multiplier from mapping.
  # If the scales are different, move the value to the second scale by transfer code from mapping.
  # Get the value to the second dimension by multiplier from mapping.
  def get_value(first_scale, first_dimension, second_scale, second_dimension, value)
    value_to_default = value / first_scale[ELEMENT_PROPERTY][first_dimension][Mapping::MULTIPLIER_KEY]

    first_default_dimension = get_default(first_scale, first_dimension)
    second_default_dimension = get_default(second_scale, second_dimension)
    transfer = @mapping.get_transfer(first_default_dimension[NAME_PROPERTY], second_default_dimension[NAME_PROPERTY])

    default_multiplier = transfer[Mapping::MULTIPLIER_KEY]
    convert_constant_before = transfer[Mapping::CONSTANT_PROPERTY][Mapping::CONSTANT_BEFORE_PROPERTY]
    convert_constant_after = transfer[Mapping::CONSTANT_PROPERTY][Mapping::CONSTANT_AFTER_PROPERTY]

    default_converted = (default_multiplier + convert_constant_before) * value_to_default + convert_constant_after
    default_converted * second_default_dimension[Mapping::MULTIPLIER_KEY]
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
    end while !current_node || current_node && current_node[ELEMENT_PROPERTY].fetch(Mapping::LAST_PROPERTY, false) === false
    {Mapping::LAST_PROPERTY => current_node[NAME_PROPERTY], Mapping::SCALE_PROPERTY => last_node}
  end

  # Checking the current node is a leaf and return it or get the the next depth via input.
  def get_next_node(current_node, direction)
    if current_node && current_node[ELEMENT_PROPERTY][Mapping::LAST_PROPERTY] === true
      current_node
    else
      @input.get_node_element(current_node, direction)
    end
  end

  # Going recursively the scale down until the default is found.
  # In case the current one is already a default, don't search further.
  def get_default(scale, chosen_dimension, current_key = 0)
    element = scale[ELEMENT_PROPERTY]
    chosen_element = element[chosen_dimension] || nil
    current_element = element[element.keys[current_key]] || nil

    if chosen_element && chosen_element[Mapping::DEFAULT_PROPERTY]
      {Mapping::MULTIPLIER_KEY => chosen_element[Mapping::MULTIPLIER_KEY], NAME_PROPERTY => chosen_dimension}
    elsif current_element && current_element[Mapping::DEFAULT_PROPERTY]
      {Mapping::MULTIPLIER_KEY => current_element[Mapping::MULTIPLIER_KEY], NAME_PROPERTY => element.keys[current_key]}
    else
      get_default(scale, chosen_dimension, current_key + 1)
    end
  end
end
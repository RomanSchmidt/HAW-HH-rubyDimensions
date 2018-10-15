require './mapping.rb'
require './renderer.rb'

# Author: Roman Schmidt, Daniel Osterholz
#
# This is the main class for the transformation logic.
# This class uses the Mapping class to get and handle the convert logic.
# All required values to handle the Mapping are called from input object.
# All outputs are delegated to the renderer object.
class Converter

  public

  NAME_KEY = 'name'
  ELEMENT_KEY = 'element'

  private

  # make sure mapping, renderer and input are initialized.
  def initialize(renderer, input, mapping)
    @renderer = renderer
    @input = input
    @mapping = mapping
    start
  end

  # Flow for a inputs of convert.
  # Recursion in case of failure is within the single steps.
  # Prints out a single line in the end. (delegated)
  def start
    @renderer.print_first_dimension
    first_result = get_dimension(Renderer::DIRECTION_IN)
    @renderer.print_second_dimension
    second_result = get_dimension(Renderer::DIRECTION_OUT)
    value = @input.get_value_to_convert

    convert(first_result[Mapping::SCALE_KEY], first_result[Mapping::LAST_KEY], second_result[Mapping::SCALE_KEY], second_result[Mapping::LAST_KEY], value)
  end

  # Get the first value in the default dimension.
  # Get both default dimensions.
  # Transfer the values from one dimension into the other.
  # Multiply the second dimension by its own multiplier to get from default to the target dimension within the second
  # scale
  def transform_value(first_scale, first_dimension, second_scale, second_dimension, value)
    default_value = value_to_default(first_scale, first_dimension)

    first_default_dimension = get_default(first_scale, first_dimension)
    second_default_dimension = get_default(second_scale, second_dimension)

    transfer = @mapping.get_transfer(first_default_dimension[NAME_KEY], second_default_dimension[NAME_KEY])
    default_converted = transfer_default_dimensions(transfer, default_value)

    default_converted * second_default_dimension[Mapping::MULTIPLIER_KEY]
  end

  # Use the transfer logic by using the transfer mapping to get from scale 1 to scale 2 of the defaults.
  # Watching the before and after constants.
  def transfer_default_dimensions(transfer, default_value)
    default_multiplier = transfer[Mapping::MULTIPLIER_KEY]
    convert_constant_before = transfer[Mapping::CONSTANT_KEY][Mapping::CONSTANT_BEFORE_KEY]
    convert_constant_after = transfer[Mapping::CONSTANT_KEY][Mapping::CONSTANT_AFTER_KEY]

    (default_multiplier + convert_constant_before) * default_value + convert_constant_after
  end

  # Divide the value by its own multiplier from the first scale to get the value in the default dimension.
  def value_to_default(first_scale, first_dimension)
    value / first_scale[ELEMENT_KEY][first_dimension][Mapping::MULTIPLIER_KEY]
  end

  # Convert the value1 to value2 and print it out
  def convert(first_scale, first_dimension, second_scale, second_dimension, value)
    calculated_value = transform_value(first_scale, first_dimension, second_scale, second_dimension, value)
    @renderer.print_single_result(first_dimension, value, second_dimension, calculated_value)
  end

  # Running a loop as long as the current node is not a leaf.
  # Each loop is printing out the current node keys to select via input and go lower the three.
  # Returns a hash with the last property and its scale three.
  def get_dimension(direction)
    last_node = nil
    current_node = {ELEMENT_KEY => @mapping.get_categories, NAME_KEY => 'categories'}
    begin
      last_node = current_node
      current_node = get_next_node(current_node, direction)
    end while !current_node || current_node && current_node[ELEMENT_KEY].fetch(Mapping::LAST_KEY, false) === false
    {Mapping::LAST_KEY => current_node[NAME_KEY], Mapping::SCALE_KEY => last_node}
  end

  # Checking the current node is a leaf and return it or get the the next depth via input.
  def get_next_node(current_node, direction)
    if current_node && current_node[ELEMENT_KEY][Mapping::LAST_KEY] === true
      current_node
    else
      @input.get_node_element(current_node, direction)
    end
  end

  # Going recursively the scale down until the default is found.
  # In case the current one is already a default, don't search further.
  def get_default(scale, chosen_dimension, current_key = 0)
    element = scale[ELEMENT_KEY]
    chosen_element = element[chosen_dimension] || nil
    current_element = element[element.keys[current_key]] || nil

    if chosen_element && chosen_element[Mapping::DEFAULT_KEY]
      {Mapping::MULTIPLIER_KEY => chosen_element[Mapping::MULTIPLIER_KEY], NAME_KEY => chosen_dimension}
    elsif current_element && current_element[Mapping::DEFAULT_KEY]
      {Mapping::MULTIPLIER_KEY => current_element[Mapping::MULTIPLIER_KEY], NAME_KEY => element.keys[current_key]}
    else
      get_default(scale, chosen_dimension, current_key + 1)
    end
  end
end
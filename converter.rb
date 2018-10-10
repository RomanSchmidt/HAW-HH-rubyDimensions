require "./mapping.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class uses the Mapping class to get and handle the convert logic.
# It should not be initialized any time.
class Converter

  protected

  LAST_PROPERTY = 'leaf'
  MULTIPLIER_PROPERTY = 'multiplier'
  CONSTANT_PROPERTY = 'constant'
  CONSTANT_BEFORE_PROPERTY = 'before'
  CONSTANT_AFTER_PROPERTY = 'after'
  DEFAULT_PROPERTY = 'default'

  public

  NAME_PROPERTY = 'name'
  ELEMENT_PROPERTY = 'element'

  # make sure mapping is initialized
  def initialize(renderer, input)
    @renderer = renderer
    @input = input
    @mapping = Mapping.new
  end

  protected

  # Get the value of the current category in the default dimension by multiplier from mapping.
  # If the scales are different, move the value to the second scale by transfer code from mapping.
  # Get the value to the second dimension by multiplier from mapping.
  def get_value(first_scale, first_dimension, second_scale, second_dimension, value)
    value_to_default = value / first_scale[ELEMENT_PROPERTY][first_dimension][MULTIPLIER_PROPERTY]

    first_default_dimension = get_default(first_scale, first_dimension)
    second_default_dimension = get_default(second_scale, second_dimension)
    transfer = @mapping.get_transfer(first_default_dimension[NAME_PROPERTY], second_default_dimension[NAME_PROPERTY])

    default_multiplier = transfer[MULTIPLIER_PROPERTY]
    convert_constant_before = transfer[CONSTANT_PROPERTY][CONSTANT_BEFORE_PROPERTY]
    convert_constant_after = transfer[CONSTANT_PROPERTY][CONSTANT_AFTER_PROPERTY]

    default_converted = (default_multiplier + convert_constant_before) * value_to_default + convert_constant_after
    default_converted * second_default_dimension[MULTIPLIER_PROPERTY]
  end

  private

  # Going recursively the scale down until the default is found.
  # In case the current one is already a default, don't search further.
  def get_default(scale, chosen_dimension, current_key = 0)
    element = scale[ELEMENT_PROPERTY]
    chosen_element = element[chosen_dimension] || nil
    current_element = element[element.keys[current_key]] || nil
    if chosen_element[DEFAULT_PROPERTY]
      {MULTIPLIER_PROPERTY => chosen_element[MULTIPLIER_PROPERTY], NAME_PROPERTY => chosen_dimension}
    elsif current_element[DEFAULT_PROPERTY]
      {MULTIPLIER_PROPERTY => current_element[MULTIPLIER_PROPERTY], NAME_PROPERTY => element.keys[current_key]}
    else
      get_default(scale, chosen_dimension, current_key + 1)
    end
  end

  # Figure out which is the default property within the scale.
  # NOTE: We just assume there is always one. No validation!
  def get_default_dimension(category, scale)
    @mapping.get_dimensions(category, scale).each do |dimension, properties|
      if properties.fetch(DEFAULT_PROPERTY)
        return dimension
      end
    end
  end
end
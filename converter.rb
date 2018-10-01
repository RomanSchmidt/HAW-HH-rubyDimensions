# Author: Roman Schmidt
#
# This class uses the Mapping class to get and handle the convert logic.
class Converter
  def initialize(mapping)
    @mapping = mapping
  end

  # Get the value of the current category in the default dimension by multiplier from mapping.
  # If the scales are different, move the value to the second scale by transfer code from mapping.
  # Get the value to the second dimension by multiplier from mapping.
  def get_value(category, first_scale, second_scale, first_dimension, second_dimension, value)
    value_to_default = value / @mapping.get_multiplier(category, first_scale, first_dimension)

    first_default_dimension = get_default_dimension(category, first_scale)
    default_multiplier = 1
    if first_scale != second_scale
      second_default_dimension = get_default_dimension(category, second_scale)
      default_multiplier = @mapping.get_transfer_multiplier(first_default_dimension, second_default_dimension)
    end

    default_converted = default_multiplier * value_to_default
    default_converted * @mapping.get_multiplier(category, second_scale, second_dimension)
  end

  private

  # Figure out which is the default property within the scale.
  # NOTE: We just assume there is always one. No validation!
  def get_default_dimension(category, scale)
    @mapping.get_dimensions(category, scale).each do |dimension, properties|
      if properties.fetch('default')
        return dimension
      end
    end
  end
end
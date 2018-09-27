class Converter
  def initialize(mapping)
    @mapping = mapping
  end

  def get_value(category, first_convert, second_convert, first_dimension, second_dimension, value)
    value_to_default = value / @mapping.get_multiplier(category, first_convert, first_dimension)

    first_default_dimension = get_default_dimension(category, first_convert)
    default_multiplier = 1
    if first_convert != second_convert
      second_default_dimension = get_default_dimension(category, second_convert)
      default_multiplier = @mapping.get_transfer_code(first_default_dimension, second_default_dimension)
    end

    default_converted = default_multiplier * value_to_default
    default_converted * @mapping.get_multiplier(category, second_convert, second_dimension)
  end

  private

  def get_default_dimension(category, first_convert)
    @mapping.get_dimensions(category, first_convert).each do |dimension, properties|
      if properties.fetch('default')
        return dimension
      end
    end
  end
end
require "./converter.rb"
require "./input_direct.rb"
require "./renderer_direct.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This Class handles the logical flow to get all parameters for a direct output.
class ConverterDirect < Converter

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
    category = get_category
    first_convert = get_convert_from(category)
    first_dimension = get_first_convert_dimension(category, first_convert)
    second_convert = get_convert_to(category)
    second_dimension = get_second_convert_dimension(category, second_convert)
    get_single(category, first_convert, second_convert, first_dimension, second_dimension)
  end

  # Get the category. e.g. metrication
  def get_category
    categories = @mapping.get_categories
    @input.get_category(categories)
  end

  # Get the scales to convert from. e.g. metrics
  def get_convert_from(category_name)
    scales = @mapping.get_scales(category_name)
    @input.get_convert_from(scales)
  end

  # Get the dimension of the first scale to convert from. e.g. mm / inc
  def get_first_convert_dimension(category_name, convert)
    dimensions = @mapping.get_dimensions(category_name, convert)
    @input.get_first_convert_dimension(dimensions, dimensions.keys.length)
  end

  # Get the dimension of the second scale to convert to. e.g. mm / inc
  def get_second_convert_dimension(category_name, convert)
    dimensions = @mapping.get_dimensions(category_name, convert)
    @input.get_second_convert_dimension(dimensions, dimensions.keys.length)
  end

  # Get the scales to convert to. e.g. metrics
  def get_convert_to(category_name)
    scales = @mapping.get_scales(category_name)
    @input.get_convert_to(scales)
  end

  # Calculate and print out the single value.
  def get_single(category, first_convert, second_convert, first_dimension, second_dimension)
    value = @input.get_value
    calculated_value = get_value(category, first_convert, second_convert, first_dimension, second_dimension, value)
    @renderer.print_single_result(first_dimension, value, second_dimension, calculated_value)
  end
end
require "./renderer.rb"
require "./input.rb"
require "./converter.rb"
require "./mapping.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This is the most important class which handles the interaction of all object.
# It is handling the logic and input flow and delegating to the other objects to care of
# get input, map data, generate values or print out.
class Dimensions

  # Initialize instance variables in the right order and make sure they get all parameters.
  # After all, start the script.
  def initialize
    @renderer = Renderer.new
    @mapping = Mapping.new(@renderer)
    @converter = Converter.new(@mapping)
    @input = Input.new(@renderer, Renderer::MIN_VALUE)
    start
  end

  private

  # Main flow for the logic.
  def start
    @renderer.print_welcome
    category = get_category
    first_convert = get_convert_from(category)
    first_dimension = get_first_convert_dimension(category, first_convert)
    second_convert = get_convert_to(category)
    second_dimension = get_second_convert_dimension(category, second_convert)
    render_type = get_render_type
    case render_type
    when Mapping::RANGE_KEY
      get_range(category, first_convert, second_convert, first_dimension, second_dimension)
      exit(0)
    when Mapping::SINGLE_KEY
      get_single(category, first_convert, second_convert, first_dimension, second_dimension)
      exit(0)
    else
      @renderer.print_wrong_render_type
      exit(1)
    end
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

  # Get the render type. e.g. single
  def get_render_type
    render_types = @mapping.get_render_types
    @input.get_render_type(render_types)
  end

  # Flow for the range inputs.
  # Recursion in case of failure.
  # Print it Out in the end.
  def get_range(category, first_convert, second_convert, first_dimension, second_dimension)
    start_value = get_start_value
    end_value = get_end_value
    if check_range_values(start_value, end_value, nil)
      step_value = get_step_value
      if check_range_values(start_value, end_value, step_value)
        generate_range(start_value, end_value, step_value, category, first_convert, second_convert, first_dimension, second_dimension)
        return
      end
      return
    end
    get_range(category, first_convert, second_convert, first_dimension, second_dimension)
  end

  # Get start value for the range.
  def get_start_value
    @input.get_start_value
  end

  # Get end value for the range.
  def get_end_value
    @input.get_end_value
  end

  # Get step value for the range.
  def get_step_value
    @input.get_step_value
  end

  # Make sure the range values are valid.
  # End value should not be bigger or equal the start value.
  # Step range should not be lower or equal 0.
  def check_range_values(start_value, end_value, step_value)
    return_value = true
    if end_value < start_value
      @renderer.print_range_error_end_low
      return_value = false
    elsif step_value != nil && step_value <= 0
      @renderer.print_range_error_step_low
      return_value = false
    end
    return_value
  end

  # Print the final range with calculation for each step.
  # Make sure the borders are set right the output.
  def generate_range(start_value, end_value, step_value, category, first_convert, second_convert, first_dimension, second_dimension)
    current_value = start_value
    i = 0
    @renderer.upper_frame
    while current_value < end_value do
      i += 1
      calculated_value = @converter.get_value(category, first_convert, second_convert, first_dimension, second_dimension, current_value)
      @renderer.print_range_element(i, current_value, calculated_value, first_dimension, second_dimension)
      current_value += step_value
    end
    @renderer.lower_frame
  end

  # Calculate and print out the single value.
  def get_single(category, first_convert, second_convert, first_dimension, second_dimension)
    value = @input.get_value
    calculated_value = @converter.get_value(category, first_convert, second_convert, first_dimension, second_dimension, value)
    @renderer.print_single_result(first_dimension, value, second_dimension, calculated_value)
  end
end
require "./input_table.rb"
require "./renderer_table.rb"
require "./converter.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This Class handles the logical flow to get all parameters for a table output.
class ConverterTable < Converter

  # Initialize instance variables in the right order and make sure they get all parameters.
  # After all, start the script.
  def initialize
    super(RendererTable.new, InputTable.new)
    start
  end

  private

  # Flow for the table inputs.
  # Recursion in case of failure.
  # Prints out a table in the end.
  def start
    start_value = get_start_value
    end_value = get_end_value
    if check_table_values(start_value, end_value, nil)
      step_value = get_step_range_value
      if check_table_values(start_value, end_value, step_value)
        generate_table(start_value, end_value, step_value)
        return
      end
      return
    end
    start
  end

  # Get start value for the table.
  def get_start_value
    @input.get_start_value
  end

  # Get end value for the table.
  def get_end_value
    @input.get_end_value
  end

  # Get step value for the table.
  def get_step_range_value
    @input.get_step_range_value
  end

  # Make sure the table values are valid.
  # End value should not be bigger or equal the start value.
  # Step range should not be lower or equal 0.
  def check_table_values(start_value, end_value, step_value)
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

  # Print the final table with calculation for each step.
  # Make sure the borders are set right the output.
  def generate_table(start_value, end_value, step_value)
    category = get_random_category
    first_convert = get_random_convert(category)
    second_convert = get_random_convert(category)
    first_dimension = get_random_dimension(category, first_convert)
    second_dimension = get_random_dimension(category, second_convert)
    current_value = start_value
    i = 0
    @renderer.print_table_header(first_dimension, second_dimension)
    while current_value <= end_value do
      i += 1
      calculated_value = get_value(category, first_convert, second_convert, first_dimension, second_dimension, current_value)
      @renderer.print_table_element(i, current_value, calculated_value)
      current_value += step_value
    end
    @renderer.lower_frame
  end

  def get_random_dimension(category, convert)
    dimensions = @mapping.get_dimensions(category, convert)
    random = Random.rand(dimensions.keys.length)
    dimensions.keys[random - 1]
  end

  def get_random_convert(category)
    converts = @mapping.get_categories[category]
    random = Random.rand(converts.keys.length)
    converts.keys[random - 1]
  end

  def get_random_category
    categories = @mapping.get_categories
    random = Random.rand(categories.keys.length)
    categories.keys[random - 1]
  end
end
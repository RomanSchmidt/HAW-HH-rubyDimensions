require "./renderer.rb"
require "./input.rb"
require "./converter.rb"
require "./mapping.rb"

class Dimensions

  def initialize
    @renderer = Renderer.new
    @mapping = Mapping.new(@renderer)
    @converter = Converter.new(@mapping)
    @input = Input.new(@renderer, Renderer::MIN_VALUE)
    start
  end

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

  private

  def get_category
    categories = @mapping.get_categories
    @input.get_category(categories)
  end

  def get_convert_from(category_name)
    category_entries = @mapping.get_convert_entries(category_name)
    @input.get_convert_from(category_entries)
  end

  def get_first_convert_dimension(category_name, convert)
    dimensions = @mapping.get_dimensions(category_name, convert)
    @input.get_first_convert_dimension(dimensions, dimensions.keys.length)
  end

  def get_second_convert_dimension(category_name, convert)
    dimensions = @mapping.get_dimensions(category_name, convert)
    @input.get_second_convert_dimension(dimensions, dimensions.keys.length)
  end

  def get_convert_to(category_name)
    convert_entries = @mapping.get_convert_entries(category_name)
    @input.get_convert_to(convert_entries)
  end

  def get_render_type
    render_types = @mapping.get_render_types
    @input.get_render_type(render_types)
  end

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

  def get_start_value
    @input.get_start_value
  end

  def get_end_value
    @input.get_end_value
  end

  def get_step_value
    @input.get_step_value
  end

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

  def get_single(category, first_convert, second_convert, first_dimension, second_dimension)
    value = @input.get_value
    calculated_value = @converter.get_value(category, first_convert, second_convert, first_dimension, second_dimension, value)
    @renderer.print_convert_result(first_dimension, value, second_dimension, calculated_value)
  end
end
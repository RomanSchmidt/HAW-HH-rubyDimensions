require "./renderer.rb"
require "./input.rb"
require "./converter.rb"
require "./mapping.rb"

class Dimensions
  MIN_VALUE = 1

  def initialize
    @renderer = Renderer.new(MIN_VALUE)
    @mapping = Mapping.new(@renderer)
    @converter = Converter.new(@mapping)
    @input = Input.new(@renderer, MIN_VALUE)
    start
  end

  private

  def start
    category = get_category
    first_convert = get_convert_from(category)
    first_dimension = get_convert_dimension(category, first_convert)
    second_convert = get_convert_to(category)
    second_dimension = get_convert_dimension(category, second_convert)
    render_type = get_render_type
    case render_type
    when Mapping::RANGE_KEY
      get_range(category, first_convert, second_convert, first_dimension, second_dimension)
      restart
    when Mapping::SINGLE_KEY
      get_single(category, first_convert, second_convert, first_dimension, second_dimension)
      restart
    else
      @renderer.print_wrong_render_type
      exit(1)
    end
  end

  def get_category
    categories = @mapping.get_categories
    max = categories.keys.length
    @renderer.print_welcome
    @renderer.print_choose_categorization(max, categories.keys)
    category = @input.get_category(max)
    categories.keys[category - 1]
  end

  def get_convert_from(category_name)
    category_entries = @mapping.get_convert_entries(category_name)
    @renderer.print_choose_convert_from(category_entries.keys.length)
    @input.get_convert_from(category_entries)
  end

  def get_convert_dimension(category_name, convert)
    dimensions = @mapping.get_dimensions(category_name, convert)
    @renderer.print_choose_dimension(dimensions.keys)
    @input.get_convert_dimension(dimensions, dimensions.keys.length)
  end

  def get_convert_to(category_name)
    convert_entries = @mapping.get_convert_entries(category_name)
    @renderer.print_choose_convert_to(convert_entries.keys.length)
    @input.get_convert(convert_entries)
  end

  def get_render_type
    render_types = @mapping.get_render_types
    @renderer.get_render_type(render_types)
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
    @renderer.get_start_value
    @input.get_float
  end

  def get_end_value
    @renderer.get_end_value
    @input.get_float
  end

  def get_step_value
    @renderer.get_step_value
    @input.get_float
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

  def restart
    if should_restart
      start
    end
    exit(0)
  end

  def should_restart
    @renderer.print_restart
    input = @input.get_confirm
    if input === nil
      @renderer.error_restart_value
      should_restart
    else
      input
    end
  end

  def get_single(category, first_convert, second_convert, first_dimension, second_dimension)
    @renderer.print_get_single_value
    value = @input.get_float
    calculated_value = @converter.get_value(category, first_convert, second_convert, first_dimension, second_dimension, value)
    @renderer.print_convert_result(first_dimension, value, second_dimension, calculated_value)
  end
end
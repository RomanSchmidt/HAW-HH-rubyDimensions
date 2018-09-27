class Input
  private

  MIN_ENTER_VALUE = 1

  public

  def initialize(renderer, mapping, converter)
    @renderer = renderer
    @mapping = mapping
    @converter = converter
  end

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

  private

  def restart
    should_restart = get_restart
    if should_restart
      start
    end
    exit(0)
  end

  def get_restart
    @renderer.print_restart
    input = gets.chop
    if input == 'y' || input == 'Y'
      true
    elsif input == 'n' || input == 'N'
      false
    else
      @renderer.error_restart_value
      get_restart
    end
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

  def generate_range(start_value, end_value, step_value, category, first_convert, second_convert, first_dimension, second_dimension)
    # multiplier = (end_value.to_f - start_value.to_f) / step_value.to_f
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

  def get_single(category, first_convert, second_convert, first_dimension, second_dimension)
    @renderer.print_get_single_value
    value = gets.chop.to_f
    calculated_value = @converter.get_value(category, first_convert, second_convert, first_dimension, second_dimension, value)
    @renderer.print_convert_result(first_dimension, value, second_dimension, calculated_value)
  end

  def get_end_value
    @renderer.get_end_value
    gets.chop.to_f
  end

  def get_start_value
    @renderer.get_start_value
    gets.chop.to_f
  end

  def get_step_value
    @renderer.get_step_value
    gets.chop.to_f
  end

  def get_render_type
    render_types = @mapping.get_render_types
    @renderer.get_render_type(render_types)
    selected = gets.chop.to_i
    if check_input(selected, render_types.length)
      render_types[selected - 1]
    else
      get_render_type
    end
  end

  def get_convert_dimension(category_name, convert)
    dimensions = @mapping.get_dimensions(category_name, convert)
    max = dimensions.keys.length
    @renderer.print_choose_dimension(MIN_ENTER_VALUE, max, dimensions.keys)

    selected = gets.chop.to_i
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      get_convert_dimension(category_name, convert)
    end
  end

  def get_convert_from(category_name)
    category_entries = @mapping.get_convert_entries(category_name)
    max = category_entries.keys.length
    @renderer.print_choose_convert_from(MIN_ENTER_VALUE, max)
    get_convert(category_entries, max)
  end

  def get_convert_to(category_name)
    convert_entries = @mapping.get_convert_entries(category_name)
    max = convert_entries.keys.length
    @renderer.print_choose_convert_to(MIN_ENTER_VALUE, max)
    get_convert(convert_entries, max)
  end

  def get_category
    categories = @mapping.get_categories
    max = categories.keys.length
    @renderer.print_welcome
    @renderer.print_choose_categorization(MIN_ENTER_VALUE, max, categories.keys)

    selected = gets.chop.to_i
    if check_input(selected, max)
      categories.keys[selected - 1]
    else
      get_category
    end
  end

  def check_input(selected, max)
    return_value = false
    if selected > max
      @renderer.print_smaller_input
    else
      if selected < MIN_ENTER_VALUE
        @renderer.print_bigger_input
      else
        return_value = true
      end
    end
    return_value
  end

  def get_convert(dimensions, max)
    @renderer.print_keys(dimensions.keys)

    selected = gets.chop.to_i
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      get_convert(dimensions, max)
    end
  end
end
require "./console_params.rb"

class Input
  public

  def initialize(renderer, min)
    @renderer = renderer
    @console_params = ConsoleParams.new(renderer)
    @params = {}
    @console_params.add_params @params
    @min_value = min
  end

  def get_category(categories)
    selected = @params['category']
    max = categories.keys.length
    if nil === selected
      @renderer.print_choose_categorization(max, categories.keys)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, max)
      categories.keys[selected - 1]
    else
      @params['category'] = nil
      get_category(categories)
    end
  end

  def get_value
    value = @params['value']
    if value === nil
      @renderer.print_get_single_value
      value = get_float
    end
    value
  end

  def get_start_value
    value = @params['start_value']
    if value === nil
      @renderer.get_start_value
      value = get_float
    end
    value
    end

  def get_step_value
    value = @params['step_value']
    if value === nil
      @renderer.get_step_value
      value = get_float
    end
    value
  end

  def get_end_value
    value = @params['end_value']
    if value === nil
      @renderer.get_end_value
      value = get_float
    end
    value
  end

  def get_convert_to(convert_entries)
    default_value = @params['second_convert']
    if nil === default_value
      @renderer.print_choose_convert_to(convert_entries.keys.length)
    end
    get_convert(convert_entries, default_value)
  end

  def get_convert_from(category_entries)
    default_value = @params['first_convert']
    if nil === default_value
      @renderer.print_choose_convert_from(category_entries.keys.length)
    end
    get_convert(category_entries, default_value)
  end

  def get_first_convert_dimension(dimensions, max)
    selected = @params['first_dimension']

    if selected === nil
      @renderer.print_choose_first_dimension(dimensions.keys)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      @params['first_dimension'] = nil
      get_first_convert_dimension(dimensions, max)
    end
  end

  def get_second_convert_dimension(dimensions, max)
    selected = @params['second_dimension']

    if selected === nil
      @renderer.print_choose_second_dimension(dimensions.keys)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end

    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      @params['second_dimension'] = nil
      get_second_convert_dimension(dimensions, max)
    end
  end

  def get_render_type(render_types)
    selected = @params['render_type']

    if selected === nil
      @renderer.get_render_type(render_types)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, render_types.length)
      render_types[selected - 1]
    else
      @params['render_type'] = nil
      get_render_type(render_types)
    end
  end

  def get_float
    begin
      STDIN.gets.chop.to_f
    rescue Exception => e
      exit(1)
    end
  end

  private

  def get_convert(dimensions, default_dimension)
    selected = default_dimension
    if selected === nil
      @renderer.print_keys(dimensions.keys)

      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, dimensions.keys.length)
      dimensions.keys[selected - 1]
    else
      get_convert(dimensions, nil)
    end
  end

  def check_input(selected, max)
    return_value = false
    if selected > max
      @renderer.print_smaller_input
    else
      if selected < @min_value
        @renderer.print_bigger_input
      else
        return_value = true
      end
    end
    return_value
  end
end
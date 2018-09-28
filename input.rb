class Input
  public

  def initialize(renderer, min)
    @renderer = renderer
    @min_value = min
  end

  def get_category(max)
    selected = gets.chop.to_i
    if check_input(selected, max)
      selected
    else
      get_category(max)
    end
  end

  def get_convert_from(category_entries)
    get_convert(category_entries)
  end

  def get_convert_dimension(dimensions, max)
    selected = gets.chop.to_i
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      get_convert_dimension(dimensions, max)
    end
  end

  def get_convert_to(convert_entries)
    get_convert(convert_entries)
  end

  def get_render_type(render_types)
    selected = gets.chop.to_i
    if check_input(selected, render_types.length)
      render_types[selected - 1]
    else
      get_render_type(render_types)
    end
  end

  def get_float
    gets.chop.to_f
  end

  def get_confirm
    input = gets.chop
    if input == 'y' || input == 'Y'
      true
    elsif input == 'n' || input == 'N'
      false
    else
      nil
    end
  end

  def get_convert(dimensions)
    @renderer.print_keys(dimensions.keys)

    selected = gets.chop.to_i
    if check_input(selected, dimensions.keys.length)
      dimensions.keys[selected - 1]
    else
      get_convert(dimensions)
    end
  end

  private

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
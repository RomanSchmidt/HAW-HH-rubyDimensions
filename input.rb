class Input
  def initialize(renderer, mapping)
    @renderer = renderer
    @mapping = mapping
  end

  def start
    clear
    category = get_category
    first_convert = get_convert_from(category)
    first_dimension = get_convert_dimension(category, first_convert)
    second_convert = get_convert_to(category)
    second_dimension = get_convert_dimension(category, second_convert)
    printf("convert from (%s) to (%s)", first_dimension, second_dimension)
  end

  private

  def get_convert_dimension(category_name, convert)
    clear
    dimensions = @mapping['category'][category_name][convert]
    max = dimensions.keys.length
    print("\n")
    printf("Choose the dimension (1 - %i): \n", max)
    @renderer.print_keys(dimensions.keys)

    selected = gets.chop.to_i
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      get_convert_dimension(category_name, convert)
      clear
    end
  end

  def get_convert_from(category_name)
    clear
    category_entry = @mapping['category'][category_name]
    max = category_entry.keys.length
    printf("Choose which to convert from (1 - %i): ", max)
    get_convert(category_entry, max)
  end

  def get_convert_to(category_name)
    clear
    category_entry = @mapping['category'][category_name]
    max = category_entry.keys.length
    printf("Choose which to convert to (1 - %i): ", max)
    get_convert(category_entry, max)
  end

  def get_category
    clear
    categories = @mapping['category']
    max = categories.keys.length
    @renderer.print_welcome
    @renderer.print_keys(categories.keys)
    print("\n")

    printf("Choose your categorization (1 - %i): ", max)
    selected = gets.chop.to_i
    if check_input(selected, max)
      categories.keys[selected - 1]
    else
      get_category
      clear
    end
  end

  def check_input(selected, max)
    return_value = false
    if selected > max
      printf("Die Zahl ist zu groß.\n")
    else
      if selected <= 0
        printf("Die Zahl ist zu klein.\n")
      else
        return_value = true
      end
    end
    return_value
  end

  def get_convert(dimensions, max)
    print("\n")
    @renderer.print_keys(dimensions.keys)

    selected = gets.chop.to_i
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      get_convert(dimensions, max)
      clear
    end
  end

  def clear
    print "\e[2J\e[f"
  end
end
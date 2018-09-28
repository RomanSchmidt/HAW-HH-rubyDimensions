class Renderer
  def initialize(min_value)
    @min_value = min_value
  end

  def print_get_single_value
    output('Enter value to convert')
  end

  def print_welcome
    output('           ### Dimension Converter in Ruby ###')
  end

  def print_range_error_end_low
    output('ERROR: End value is lower then start range!')
  end

  def print_range_error_step_low
    output('ERROR: Step value must be bigger then 0!')
  end

  def print_range_element(position, value, calculated_value, first_dimension, second_dimension)
    output("##{position}: #{value.round(2)} (#{first_dimension}) => #{calculated_value.round(2)} (#{second_dimension})", false, false)
  end

  def get_end_value
    output('Enter end value')
  end

  def get_start_value
    output('Enter start value')
  end

  def get_step_value
    output('Enter step value')
  end

  def print_wrong_render_type
    output('ERROR: Unknown render type!')
  end

  def get_render_type(types)
    output('Choose render type')
    print_keys(types)
  end

  def print_convert_result(first_dimension, value, second_dimension, calculated_value)
    print_single(first_dimension, value, second_dimension, calculated_value)
  end

  def print_choose_dimension(keys)
    output("Choose the dimension (#{@min_value} - #{keys.length})")
    print_keys(keys)
  end

  def print_choose_convert_from(max)
    output("Choose which to convert from (#{@min_value} - #{max})")
  end

  def print_choose_convert_to(max)
    output("Choose which to convert to (#{@min_value} - #{max})")
  end

  def print_choose_categorization(max, categories)
    output("Choose your categorization (#{@min_value} - #{max})")
    print_keys(categories)
  end

  def print_smaller_input
    output('ERROR: Selected number too big!')
  end

  def print_bigger_input
    output('ERROR: Selected number too small!')
  end

  def print_keys(keys)
    upper_frame
    i = 0
    keys.each do |dimension|
      i += 1
      output("##{i}: #{dimension}", false, false)
    end
    lower_frame
  end

  def print_err_trans_dim(first_dimension)
    output("ERROR: Transfer dimension not found: #{first_dimension}!")
  end

  def print_restart
    output('Restart? (y / n)')
  end

  def error_restart_value
    output('ERROR: Restart value invalid!')
  end

  def upper_frame
    printf("╔%1$s╗\n", '═' * 76)
  end

  def lower_frame
    printf("╚%1$s╝\n", '═' * 76)
  end

  private

  def print_single(first_dimension, value, second_dimension, calculated_value)
    output("single convert from #{value} (#{first_dimension}) to #{calculated_value.round(2)} (#{second_dimension})")
  end

  def print_range(first_dimension, value, second_dimension)
    output("range: convert from #{value} (#{first_dimension}) to (#{second_dimension})")
  end

  def output(value, with_upper_frame = true, with_lower_frame = true)
    with_upper_frame && upper_frame
    printf("%1$s %2$-56s %1$5s\n", '║', value.to_s)
    with_lower_frame && lower_frame
  end
end

class Renderer
  MIN_VALUE = 1
  OUTPUT_LENGTH = 70

  def print_get_single_value
    output('Enter value to convert')
  end

  def print_welcome
    value = '#### Dimension Converter in Ruby ###'
    output(' ' * ((OUTPUT_LENGTH - value.length) / 2) + value)
  end

  def print_range_error_end_low
    output_error('End value is lower then start range!')
  end

  def print_range_error_step_low
    output_error('Step value must be bigger then 0!')
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
    output_error('Unknown render type!')
  end

  def get_render_type(types)
    output('Choose render type')
    print_keys(types)
  end

  def print_convert_result(first_dimension, value, second_dimension, calculated_value)
    print_single(first_dimension, value, second_dimension, calculated_value)
  end

  def print_choose_first_dimension(keys)
    output("Choose first dimension (#{MIN_VALUE} - #{keys.length})")
    print_keys(keys)
  end

  def print_choose_second_dimension(keys)
    output("Choose second dimension (#{MIN_VALUE} - #{keys.length})")
    print_keys(keys)
  end

  def print_choose_convert_from(max)
    output("Choose which to convert from (#{MIN_VALUE} - #{max})")
  end

  def print_choose_convert_to(max)
    output("Choose which to convert to (#{MIN_VALUE} - #{max})")
  end

  def print_choose_categorization(max, categories)
    output("Choose your categorization (#{MIN_VALUE} - #{max})")
    print_keys(categories)
  end

  def print_smaller_input
    output_error('Selected number too big!')
  end

  def print_bigger_input
    output_error('Selected number too small!')
  end

  def print_param_to_low(name)
    output_error("\"#{name}\" number too small!")
  end

  def print_error_just_numeric(name)
    output_error("\"#{name}\" value is not numeric!")
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
    output_error("Transfer dimension not found: #{first_dimension}!")
  end

  def upper_frame
    printf("╔%1$s╗\n", '═' * OUTPUT_LENGTH)
  end

  def lower_frame
    printf("╚%1$s╝\n", '═' * OUTPUT_LENGTH)
  end

  def print_error_param(param)
    output_error("Unknown parameter (#{param})!")
  end

  def print_manual
    output("You can start this script without parameters to get the menu.", true, false)
    output("", false, false)
    output("You can put one or more following parameters to skip the input:", false, false)
    output("  -h -m to get this help screen", false, false)
    output("  -category=[integer] e.g. 0 = metrication", false, false)
    output("  -first_convert=[integer] e.g. 0 = metric", false, false)
    output("  -second_convert=[integer] e.g. 0 = metric", false, false)
    output("  -first_dimension=[integer] e.g. 0 = mm / inc", false, false)
    output("  -second_dimension=[integer] e.g. 0 = mm / inc", false, false)
    output("  -render_type=[integer] 0=range, 1=single", false, false)
    output("  -value=[float] value for single rendering", false, false)
    output("  -start_value=[float] start value for range rendering", false, false)
    output("  -end_value=[float] end value for range rendering", false, false)
    output("  -step_value=[float] step value for range rendering", false, true)
  end

  private

  def output_error(value)
    upper_frame
    printf("%1$s \e[31m%2$-#{OUTPUT_LENGTH - 6}s\e[0m %1$5s\n", '║', value.to_s)
    lower_frame
  end

  def print_single(first_dimension, value, second_dimension, calculated_value)
    output("single convert from #{value} (#{first_dimension}) to #{calculated_value.round(2)} (#{second_dimension})")
  end

  def print_range(first_dimension, value, second_dimension)
    output("range: convert from #{value} (#{first_dimension}) to (#{second_dimension})")
  end

  def output(value, with_upper_frame = true, with_lower_frame = true)
    with_upper_frame && upper_frame
    printf("%1$s %2$-#{OUTPUT_LENGTH - 6}s %1$5s\n", '║', value.to_s)
    with_lower_frame && lower_frame
  end
end

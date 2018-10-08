# Author: Roman Schmidt, Daniel Osterholz
#
# This class handles all the output.
# It is also drawing a frame around the output and makes errors red inside.
class Renderer

  # Change the output tables shorter or larger in default length.
  OUTPUT_LENGTH = 70

  # Regular output delegation.
  def print_get_output_type(types, min_value)
    output("Enter output type (#{min_value} - #{types.length})")
    print_keys(types)
  end

  # Regular error output delegation.
  def print_error_output(type)
    output_error("Unknown type: #{type}")
  end

  # Print welcome header and information about how to get the manual.
  def print_welcome
    value1 = '#### Dimension Converter in Ruby ### '
    output(' ' * ((OUTPUT_LENGTH - value1.length) / 2) + value1, true, false)
    value2 = '(-h / -m for manual)'
    output(' ' * ((OUTPUT_LENGTH - value2.length) / 2) + value2, false, true)
  end

  # Final output of single render.
  def print_single_result(first_dimension, value, second_dimension, calculated_value)
    output("single convert from #{value} (#{first_dimension}) to #{calculated_value.round(2)} (#{second_dimension})")
  end

  # Regular error output delegation.
  def print_smaller_input
    output_error('Selected number too big!')
  end

  # Regular error output delegation.
  def print_bigger_input
    output_error('Selected number too small!')
  end

  # Regular error output delegation.
  def print_param_to_low(name)
    output_error("\"#{name}\" number too small!")
  end

  # Regular error output delegation.
  def print_error_just_numeric(name)
    output_error("\"#{name}\" value is not numeric!")
  end

  # Looping over all keys and draw them within one frame.
  def print_keys(keys)
    upper_frame
    i = 0
    keys.each do |dimension|
      i += 1
      output("##{i}: #{dimension}", false, false)
    end
    lower_frame
  end

  # Regular output delegation.
  def print_err_trans_dim(first_dimension)
    output_error("Transfer dimension not found: #{first_dimension}!")
  end

  # Draw upper frame border.
  def upper_frame
    printf("╔%1$s╗\n", '═' * OUTPUT_LENGTH)
  end

  # Draw lower frame border.
  def lower_frame
    printf("╚%1$s╝\n", '═' * OUTPUT_LENGTH)
  end

  # Regular error output delegation.
  def print_error_param(param)
    output_error("Unknown parameter (#{param})!")
  end

  # Output of the whole manual / help.
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

  # Output with colorizing content red in needed default length.
  def output_error(value)
    upper_frame
    printf("%1$s \e[31m%2$-#{OUTPUT_LENGTH - 6}s\e[0m %1$5s\n", '║', value.to_s)
    lower_frame
  end

  # Calculating the default length of output and draw frame + borders if needed.
  def output(value, with_upper_frame = true, with_lower_frame = true)
    with_upper_frame && upper_frame
    printf("%1$s %2$-#{OUTPUT_LENGTH - 6}s %1$5s\n", '║', value.to_s)
    with_lower_frame && lower_frame
  end
end

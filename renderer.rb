# Author: Roman Schmidt, Daniel Osterholz
#
# This class handles all the output.
# It is also drawing a frame around the output and makes errors red inside.
class Renderer

  private

  # Change the output tables shorter or larger in default length.
  OUTPUT_LENGTH = 70

  # Constant strings for output
  STRING_CONVERT_TO = 'to convert to'
  STRING_CONVERT_FROM = 'to convert from'

  public

  # Mostly used for printout to help the user.
  DIRECTION_IN = :in_direction
  DIRECTION_OUT = :out_direction

  def direction_valid?(direction)
    Renderer::DIRECTION_IN === direction || Renderer::DIRECTION_OUT
  end

  # Print out selectables with topic.
  def print_select(min_value, keys, name, direction)
    direction_string = direction === DIRECTION_IN ? STRING_CONVERT_TO : STRING_CONVERT_FROM
    output("Please select #{name} #{direction_string}. (#{min_value} - #{keys.length})")
    print_keys(keys)
  end

  # Regular output delegation.
  def print_first_dimension
    output('First dimension')
  end

  # Regular output delegation.
  def print_second_dimension
    output('Second dimension')
  end

  # Regular output delegation.
  def get_value_to_convert
    output('Enter value to convert')
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
  def error_input_big
    output_error('Selected number too big!')
  end

  # Regular error output delegation.
  def error_input_small
    output_error('Selected number too small!')
  end

  # Regular output delegation.
  # Switch output in cse second dimension ist giver or not.
  def error_transfer_dimension(first_dimension, second_dimension = nil)
    if second_dimension
      output_error("Not able to convert from \"#{first_dimension}\" to \"#{second_dimension}\"!")
    else
      output_error("Transfer dimension not found: #{first_dimension}!")
    end
  end

  private

  # Looping over all keys and draw them within one frame.
  def print_keys(keys)
    print_upper_border
    i = 0
    keys.each do |dimension|
      i += 1
      output("##{i}: #{dimension}", false, false)
    end
    print_lower_border
  end

  # Draw upper frame border.
  def print_upper_border
    printf("╔%1$s╗\n", '═' * OUTPUT_LENGTH)
  end

  # Draw lower frame border.
  def print_lower_border
    printf("╚%1$s╝\n", '═' * OUTPUT_LENGTH)
  end

  # Output with colorizing content red in needed default length.
  def output_error(value)
    print_upper_border
    printf("%1$s \e[31m%2$-#{OUTPUT_LENGTH - 6}s\e[0m %1$5s\n", '║', 'ERROR: ' + value.to_s)
    print_lower_border
  end

  # Calculating the default length of output and draw frame + borders if needed.
  def output(value, with_upper_frame = true, with_lower_frame = true)
    with_upper_frame && print_upper_border
    printf("%1$s %2$-#{OUTPUT_LENGTH - 6}s %1$5s\n", '║', value.to_s)
    with_lower_frame && print_lower_border
  end
end
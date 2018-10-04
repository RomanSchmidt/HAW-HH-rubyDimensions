require "./renderer.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# All outputs that are just for table output.
# See parent class.
class RendererTable < Renderer
  # Regular output delegation.
  def print_range_error_end_low
    output_error('End value is lower then start range!')
  end

  # Regular output delegation.
  def print_range_error_step_low
    output_error('Step value must be bigger then 0!')
  end

  def print_table_header(first_dimension, second_dimension)
    upper_frame
    output("Convert table from #{first_dimension} to #{second_dimension}", false, false)
  end

  # Drawing an range element without frames in upper / lower.
  def print_table_element(position, value, calculated_value)
    output("##{position}: #{value.round(2)} => #{calculated_value.round(2)}", false, false)
  end

  # Regular output delegation.
  def get_end_value
    output('Enter end value')
  end

  # Regular output delegation.
  def get_start_value
    output('Enter start value')
  end

  # Regular output delegation.
  def get_step_range_value
    output('Enter step value')
  end
end
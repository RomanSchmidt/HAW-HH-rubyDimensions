require "./renderer.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# All outputs that are just for direct output.
# See parent class.
class RendererDirect < Renderer
  # Regular output delegation.
  def print_get_single_value
    output('Enter value to convert')
  end

  # Regular output delegation. with keys.
  def print_choose_first_dimension(keys, min_value)
    output("Choose first dimension (#{min_value} - #{keys.length})")
    print_keys(keys)
  end

  # Regular output delegation. with keys.
  def print_choose_second_dimension(keys, min_value)
    output("Choose second dimension (#{min_value} - #{keys.length})")
    print_keys(keys)
  end

  # Regular output delegation.
  def print_choose_convert_from(max, min_value)
    output("Choose which to convert from (#{min_value} - #{max})")
  end

  # Regular output delegation.
  def print_choose_convert_to(max, min_value)
    output("Choose which to convert to (#{min_value} - #{max})")
  end

  # Regular output delegation. with keys.
  def print_choose_categorization(max, min_value, categories)
    output("Choose your categorization (#{min_value} - #{max})")
    print_keys(categories)
  end
end
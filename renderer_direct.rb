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
  def print_choose_first_dimension(keys)
    output("Choose first dimension (#{MIN_VALUE} - #{keys.length})")
    print_keys(keys)
  end

  # Regular output delegation. with keys.
  def print_choose_second_dimension(keys)
    output("Choose second dimension (#{MIN_VALUE} - #{keys.length})")
    print_keys(keys)
  end

  # Regular output delegation.
  def print_choose_convert_from(max)
    output("Choose which to convert from (#{MIN_VALUE} - #{max})")
  end

  # Regular output delegation.
  def print_choose_convert_to(max)
    output("Choose which to convert to (#{MIN_VALUE} - #{max})")
  end

  # Regular output delegation. with keys.
  def print_choose_categorization(max, categories)
    output("Choose your categorization (#{MIN_VALUE} - #{max})")
    print_keys(categories)
  end
end
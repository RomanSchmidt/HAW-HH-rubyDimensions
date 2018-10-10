require "./renderer.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# All outputs that are just for direct output.
# See parent class.
class RendererDirect < Renderer
  # Print out selectables with topic.
  def print_select(min_value, keys, name, direction)
    direction_string = direction === DIRECTION_IN ? 'to convert to' : 'to convert from'
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
  def print_get_single_value
    output('Enter value to convert')
  end
end
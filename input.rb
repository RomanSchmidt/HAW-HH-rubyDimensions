# Author: Roman Schmidt, Daniel Osterholz
#
# This class handles the input from console if its not set by params.
# If input is not within min and max value, try again.
# If input is from params, set this key to nil.
# Params from console are mapped by ConsoleParams class.
class Input
  private

  # The default minimum value for inputs.
  # Can be changed e.g. for 0 = general exit or to start from instead of 1.
  MIN_VALUE = 1

  # Makes sure renderer is initialized
  def initialize(renderer)
    @renderer = renderer
  end

  public

  # Print the current selectables and get + check the input to return one.
  # Returns a hash with the name and the chosen node.
  # Recursion in case of false input.
  def get_node_element(node, direction)
    if node_valid?(node) === false || @renderer.direction_valid?(direction) === false
      return nil
    end
    node_element = node[Converter::ELEMENT_KEY]
    @renderer.print_select(Input::MIN_VALUE, node_element.keys, node[Converter::NAME_KEY], direction)
    begin
      selected = STDIN.gets.chop.to_i
    rescue Exception => e
      exit(1)
    end
    if input_valid?(selected, node_element.keys.length)
      {Converter::ELEMENT_KEY => node_element[node_element.keys[selected - 1]], Converter::NAME_KEY => node_element.keys[selected - 1]}
    else
      get_node_element(node, direction)
    end
  end

  # Get value to convert from
  def get_value_to_convert
    @renderer.get_value_to_convert
    get_float
  end

  private

  def node_valid?(node)
    if node.is_a?(Hash) === false
      return false
    end
    if node.fetch(Converter::ELEMENT_KEY, nil) === nil
      return false
    end
    if node.fetch(Converter::ELEMENT_KEY, nil) === nil
      return false
    end
    true
  end

  # General get float function with a catch block for ctrl + c
  def get_float
    begin
      STDIN.gets.chop.to_f
    rescue Exception => e
      exit(1)
    end
  end

  # Check function for most inputs.
  # Making sure value is within the min / max range with error rendering.
  def input_valid?(selected, max)
    is_valid = false
    if selected > max
      @renderer.error_input_big
    else
      if selected < Input::MIN_VALUE
        @renderer.error_input_small
      else
        is_valid = true
      end
    end
    is_valid
  end
end
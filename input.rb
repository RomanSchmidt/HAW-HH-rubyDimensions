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

  public

  # Get Renderer as parameters
  # Create an instance of ConsoleParams get them into an instance variable.
  def initialize(renderer)
    @renderer = renderer
  end

  # Print the current selectables and get + check the input to return one.
  # Returns a hash with the name and the chosen node.
  def get_node_element(node, direction)
    node_element = node[Converter::ELEMENT_PROPERTY]
    @renderer.print_select(MIN_VALUE, node_element.keys, node[Converter::NAME_PROPERTY], direction)
    begin
      selected = STDIN.gets.chop.to_i
    rescue Exception => e
      exit(1)
    end
    if check_input(selected, node_element.keys.length)
      {Converter::ELEMENT_PROPERTY => node_element[node_element.keys[selected - 1]], Converter::NAME_PROPERTY => node_element.keys[selected - 1]}
    else
      get_node_element(node, direction)
    end
  end

  # Get value for direct render with params fallback. No check! No recursion!
  def get_value
    @renderer.print_get_single_value
    get_float
  end

  protected

  # General get float function with a catch block
  def get_float
    begin
      STDIN.gets.chop.to_f
    rescue Exception => e
      exit(1)
    end
  end

  # Check function for most inputs.
  # Making sure value is within the min / max range with error rendering.
  def check_input(selected, max)
    return_value = false
    if selected > max
      @renderer.error_smaller_input
    else
      if selected < MIN_VALUE
        @renderer.error_bigger_input
      else
        return_value = true
      end
    end
    return_value
  end
end
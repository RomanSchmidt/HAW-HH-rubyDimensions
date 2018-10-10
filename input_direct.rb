require "./input.rb"
require "./renderer_direct.rb"
require "./converter.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class  catches all inputs are needed for a direct conversion.
# See parent class description.
class InputDirect < Input

  # Get Renderer as parameters
  # Create an instance of ConsoleParams get them into an instance variable.
  def initialize
    super(RendererDirect.new)
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
    value = @params['value']
    if value === nil
      @renderer.print_get_single_value
      value = get_float
    end
    @params['value'] = value
  end
end
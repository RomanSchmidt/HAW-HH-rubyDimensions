require "./converter.rb"
require "./renderer.rb"
require "./input.rb"#
require "./mapping.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class
class Main
  def initialize
    renderer = Renderer.new
    renderer.print_welcome
    mapping = Mapping.new(renderer)
    Converter.new(renderer, Input.new(renderer), mapping)
  end
end

Main.new
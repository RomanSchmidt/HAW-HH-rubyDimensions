require "./renderer.rb"
require "./input.rb"
require "./converter.rb"
require "./mapping.rb"

class Main
  def initialize
    @renderer = Renderer.new
    @mapping = Mapping.new(@renderer)
    @converter = Converter.new(@mapping)
    @input = Input.new(@renderer, @mapping, @converter)
    self.start
  end

  def start
    @input.start
  end
end

Main.new
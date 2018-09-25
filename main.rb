require "./renderer.rb"
require "./input.rb"
require "json"

class Main
  def initialize
    @renderer = Renderer.new
    @mapping = JSON.parse(File.read('mapping.json'))
    @input = Input.new(@renderer, @mapping)
    self.start
  end

  def start
    @input.start
  end
end

Main.new
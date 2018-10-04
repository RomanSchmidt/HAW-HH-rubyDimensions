require "./converter_direct.rb"
require "./converter_table.rb"
require "./renderer.rb"
require "./input.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class
class Main
  OUTPUT_TYPES = %w[direct table]

  def initialize
    @renderer = Renderer.new
    @input = Input.new(@renderer, Renderer::MIN_VALUE)
    @renderer.print_welcome
    choose_output
  end

  private

  # Get the information which output type to choose and start the process.
  def choose_output
    output_types = @input.get_output_type(OUTPUT_TYPES)
    case output_types
    when OUTPUT_TYPES[0]
      ConverterDirect.new
    when OUTPUT_TYPES[1]
      ConverterTable.new
    else
      @renderer.print_error_output(output_types)
      exit(1)
    end
    exit(0)
  end
end

Main.new
require "./console_params.rb"

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
    @params = {}
    init_params
  end

  # Get the value of output_type (direct or table)
  def get_output_type(output_types)
    selected = @params['output_type']
    if nil === selected
      @renderer.print_get_output_type(output_types, MIN_VALUE)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, output_types.length)
      output_types[selected - 1]
    else
      get_output_type(output_types)
    end
  end

  protected

  # Map the params from console to an instance var
  def init_params
    console_params = ConsoleParams.new(@renderer, MIN_VALUE)
    console_params.add_params(@params)
  end

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
      @renderer.print_smaller_input
    else
      if selected < MIN_VALUE
        @renderer.print_bigger_input
      else
        return_value = true
      end
    end
    return_value
  end
end
require "./input.rb"
require "./renderer_table.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class catches all parameters a table renderer needs.
# See parent class description.
class InputTable < Input

  # Get Renderer and min_value as parameters
  # Create an instance of ConsoleParams get them into an instance variable.
  def initialize
    super(RendererTable.new, RendererTable::MIN_VALUE)
  end

  # Get start value for table render with params fallback. No check! No recursion!
  def get_start_value
    value = @params['start_value']
    if value === nil
      @renderer.get_start_value
      value = get_float
    end
    value
  end

  # Get step value for table render with params fallback. No check! No recursion!
  def get_step_range_value
    value = @params['step_value']
    if value === nil
      @renderer.get_step_range_value
      value = get_float
    end
    value
  end

  # Get end value for table render with params fallback. No check! No recursion!
  def get_end_value
    value = @params['end_value']
    if value === nil
      @renderer.get_end_value
      value = get_float
    end
    value
  end
end
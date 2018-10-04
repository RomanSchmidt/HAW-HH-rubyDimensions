require "./input.rb"
require "./renderer_direct.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class  catches all inputs are needed for a direct conversion.
# See parent class description.
class InputDirect < Input

  # Get Renderer and min_value as parameters
  # Create an instance of ConsoleParams get them into an instance variable.
  def initialize
    super(RendererDirect.new, RendererDirect::MIN_VALUE)
  end

  # Get category with params fallback, check and recursion.
  def get_category(categories)
    selected = @params['category']
    max = categories.keys.length
    if nil === selected
      @renderer.print_choose_categorization(max, categories.keys)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, max)
      categories.keys[selected - 1]
    else
      @params['category'] = nil
      get_category(categories)
    end
  end

  # Get value for direct render with params fallback. No check! No recursion!
  def get_value
    value = @params['value']
    if value === nil
      @renderer.print_get_single_value
      value = get_float
    end
    value
  end

  # Get convert to value with params fallback. Delegating to general get_convert.
  def get_convert_to(scale)
    default_value = @params['second_convert']
    if nil === default_value
      @renderer.print_choose_convert_to(scale.keys.length)
    end
    get_convert(scale, default_value)
  end

  # Get convert from value with params fallback. Delegating to general get_convert.
  def get_convert_from(scale)
    default_value = @params['first_convert']
    if nil === default_value
      @renderer.print_choose_convert_from(scale.keys.length)
    end
    get_convert(scale, default_value)
  end

  # Get first dimension with params fallback, check and recursion.
  def get_first_convert_dimension(dimensions, max)
    selected = @params['first_dimension']

    if selected === nil
      @renderer.print_choose_first_dimension(dimensions.keys)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      @params['first_dimension'] = nil
      get_first_convert_dimension(dimensions, max)
    end
  end

  # Get second dimension with params fallback, check and recursion.
  def get_second_convert_dimension(dimensions, max)
    selected = @params['second_dimension']

    if selected === nil
      @renderer.print_choose_second_dimension(dimensions.keys)
      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end

    if check_input(selected, max)
      dimensions.keys[selected - 1]
    else
      @params['second_dimension'] = nil
      get_second_convert_dimension(dimensions, max)
    end
  end

  private

  # General function for convert with check and recursion.
  def get_convert(dimensions, default_dimension)
    selected = default_dimension
    if selected === nil
      @renderer.print_keys(dimensions.keys)

      begin
        selected = STDIN.gets.chop.to_i
      rescue Exception => e
        exit(1)
      end
    end
    if check_input(selected, dimensions.keys.length)
      dimensions.keys[selected - 1]
    else
      get_convert(dimensions, nil)
    end
  end
end
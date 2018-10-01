# Author: Roman Schmidt
#
# This class maps all client params, clean them up and save them in params instance variable.
class ConsoleParams

  # Get Renderer as param.
  # Get all Params but check for help / manual print after that.
  def initialize(renderer)
    @renderer = renderer
    @params = {}
    get_params
    check_for_help
  end

  # move all valid params to given container
  def add_params(container)
    @params.each do |param, value|
      if value.match(/^[0-9\.]+$/)
        value = value.to_f
      else
        @renderer.print_error_just_numeric(param)
        exit(1)
      end
      if value.to_i < Renderer::MIN_VALUE
        @renderer.print_param_to_low(value)
        exit(1)
      end
      container[param] = value
    end
  end

  private

  # If help / manual is called, print it out and exit.
  def check_for_help
    if @params['h'] || @params['m']
      @renderer.print_manual
      exit(0)
    end
  end

  # Get all params and send then to clean_up
  def get_params
    params_income = ARGV

    params_income.each do |param|
      clean_up_param(param)
    end
  end

  # Take care the param is starting with "-", have just one of it.
  # Also make sure it has one value or set just true as value.
  def clean_up_param(param)
    matched = false
    match = param.match(/^-([^-]+)$/)
    if match && match[1]
      match = match[1].split("=")
      @params[match[0]] = match[1] || true
      matched = true
    end
    if false === matched
      @renderer.print_error_param(param)
      exit(1)
    end
  end
end
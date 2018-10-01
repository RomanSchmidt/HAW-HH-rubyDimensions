class ConsoleParams
  def initialize(renderer)
    @renderer = renderer
    @params = {}
    get_params
    check_for_help
  end

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

  def check_for_help
    if @params['h'] || @params['m']
      @renderer.print_manual
      exit(0)
    end
  end

  def get_params
    params_income = ARGV

    params_income.each do |param|
      clean_up_param param
    end
  end

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
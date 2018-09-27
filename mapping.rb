require "json"

class Mapping
  private

  RANGE_KEY = 'range'
  SINGLE_KEY = 'single'
  RENDER_TYPE_KEY = 'renderType'
  CATEGORY_KEY = 'category'
  TRANSFER_CODE_KEY = 'transferCode'
  MULTIPLIER_KEY = 'multiplier'

  public

  def initialize(renderer)
    @mapping = JSON.parse(File.read('mapping.json'))
    @renderer = renderer
  end

  def get_render_types
    @mapping[Mapping::RENDER_TYPE_KEY]
  end

  def get_categories
    @mapping[Mapping::CATEGORY_KEY]
  end

  def get_convert_entries(category_name)
    @mapping[Mapping::CATEGORY_KEY][category_name]
  end

  def get_dimensions(category_name, convert)
    @mapping[Mapping::CATEGORY_KEY][category_name][convert]
  end

  def get_multiplier (category_name, convert, dimension)
    @mapping[Mapping::CATEGORY_KEY][category_name][convert][dimension].fetch(MULTIPLIER_KEY)
  end

  def get_transfer_code(first_dimension, second_dimension)
    first_trans_dim = @mapping[Mapping::TRANSFER_CODE_KEY].fetch(first_dimension, nil)
    if nil === first_trans_dim
      @renderer.print_err_trans_dim(first_dimension)
      exit(1)
    end
    multiplier = first_trans_dim.fetch(second_dimension, nil)
    if nil === multiplier
      @renderer.print_err_trans_dim(second_dimension)
      exit(1)
    end
    multiplier
  end
end
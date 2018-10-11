require "json"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class is acting like a DataBase model. Its catching the mapping (from a json) in this case,
# and providing methods to to handle them right.
class Mapping
  public

  CATEGORY_KEY = 'category'
  TRANSFER_CODE_KEY = 'transferCode'
  MULTIPLIER_KEY = 'multiplier'
  LAST_PROPERTY = 'leaf'
  CONSTANT_PROPERTY = 'constant'
  CONSTANT_BEFORE_PROPERTY = 'before'
  CONSTANT_AFTER_PROPERTY = 'after'
  DEFAULT_PROPERTY = 'default'
  SCALE_PROPERTY = 'scale'

  public

  # Get the renderer as parameter in case of Error.
  # Get the file and parse it to an object.
  def initialize(renderer)
    @mapping = JSON.parse(File.read('mapping.json'))
    @renderer = renderer
  end

  # Returns all possible categories.
  def get_categories
    @mapping[Mapping::CATEGORY_KEY]
  end

  # Return all scales from a category.
  def get_scales(category_name)
    @mapping[Mapping::CATEGORY_KEY][category_name]
  end

  # Return all dimensions of a scale.
  def get_dimensions(category_name, convert)
    @mapping[Mapping::CATEGORY_KEY][category_name][convert]
  end

  # Return multiplier of a dimension.
  def get_multiplier (category_name, convert, dimension)
    @mapping[Mapping::CATEGORY_KEY][category_name][convert][dimension][Mapping::MULTIPLIER_KEY]
  end

  def get_transfer_map(dimension_name)
    @mapping[Mapping::TRANSFER_CODE_KEY][dimension_name]
  end

  # Return the transfer hash from first to second dimension if it exists or exit with warning.
  # {multiplier: num, constant: num}
  def get_transfer(first_dimension, second_dimension)
    if first_dimension == second_dimension
      return {Mapping::MULTIPLIER_KEY => 1, Mapping::CONSTANT_PROPERTY => {Mapping::CONSTANT_BEFORE_PROPERTY => 0, Mapping::CONSTANT_AFTER_PROPERTY => 0}}
    end

    first_trans_dim = @mapping[Mapping::TRANSFER_CODE_KEY][first_dimension]
    if nil === first_trans_dim
      @renderer.print_err_trans_dim(first_dimension)
      exit(1)
    end
    transfer = first_trans_dim[second_dimension]
    if nil === transfer
      @renderer.print_err_trans_dim(first_dimension, second_dimension)
      exit(1)
    end
    transfer
  end
end
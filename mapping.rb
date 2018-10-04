require "json"
require "./renderer.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class is acting like a DataBase model. Its catching the mapping (from a json) in this case,
# and providing methods to to handle them right.
class Mapping
  private

  RANGE_KEY = 'range'
  SINGLE_KEY = 'single'
  CATEGORY_KEY = 'category'
  TRANSFER_CODE_KEY = 'transferCode'
  MULTIPLIER_KEY = 'multiplier'

  public

  # Get the renderer as parameter in case of Error.
  # Get the file and parse it to an object.
  def initialize
    @mapping = JSON.parse(File.read('mapping.json'))
    @renderer = Renderer.new
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
    @mapping[Mapping::CATEGORY_KEY][category_name][convert][dimension].fetch(MULTIPLIER_KEY)
  end

  # Return the transfer multiplier from first to second dimension if it exists or exit with warning.
  def get_transfer_multiplier(first_dimension, second_dimension)
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
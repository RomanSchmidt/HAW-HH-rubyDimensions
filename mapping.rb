require "json"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class is acting like a DataBase model. It loads the mapping (from a json) in this case,
# and providing methods to to handle them right.
class Mapping
  private

  CATEGORY_KEY = 'category'
  TRANSFER_CODE_KEY = 'transferCode'

  public

  MULTIPLIER_KEY = 'multiplier'
  LAST_KEY = 'leaf'
  CONSTANT_KEY = 'constant'
  CONSTANT_BEFORE_KEY = 'before'
  CONSTANT_AFTER_KEY = 'after'
  DEFAULT_KEY = 'default'
  SCALE_KEY = 'scale'

  # Get the renderer as parameter in case of Error.
  # Get the JSON file and parse it to a float.
  def initialize(renderer)
    @mapping = JSON.parse(File.read('mapping.json'))
    @renderer = renderer
  end

  # Returns all possible categories.
  def get_categories
    @mapping[Mapping::CATEGORY_KEY]
  end

  # Return the transfer hash from first to second dimension if it exists or exit with warning.
  # {Mapping::MULTIPLIER_KEY: num, Mapping::CONSTANT_KEY: {Mapping::CONSTANT_BEFORE_KEY: num, Mapping::CONSTANT_AFTER_KEY: mum}}
  def get_transfer(first_dimension, second_dimension)
    if first_dimension == second_dimension
      return {Mapping::MULTIPLIER_KEY => 1, Mapping::CONSTANT_KEY => {Mapping::CONSTANT_BEFORE_KEY => 0, Mapping::CONSTANT_AFTER_KEY => 0}}
    end

    first_trans_dim = @mapping[Mapping::TRANSFER_CODE_KEY][first_dimension]
    if nil === first_trans_dim
      @renderer.error_transfer_dimension(first_dimension)
      return nil
    end
    transfer = first_trans_dim[second_dimension]
    if nil === transfer
      @renderer.error_transfer_dimension(first_dimension, second_dimension)
      return nil
    end
    transfer
  end
end
require "./dimensions.rb"

# Author: Roman Schmidt, Daniel Osterholz
#
# This class is doing almost nothing the just to initialize the dimensions.
# In future it is there to make sure Dimensions will get the right dependencies for alternative
# rendering, calclulating or what ever.
# Currently its pretty empty.
class Main
  def initialize
    Dimensions.new
  end
end

Main.new
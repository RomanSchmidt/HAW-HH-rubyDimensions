class Renderer
  def printWelcome
    printf("Dimension Converter in Ruby\n")
  end

  def printKeys(keys)
    i = 0
    keys.each do |dimension|
      i += 1
      printf("#%d %s\n", i, dimension)
    end
  end
end

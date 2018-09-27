class Renderer
  def print_welcome
    printf("Dimension Converter in Ruby\n")
  end

  def print_keys(keys)
    i = 0
    keys.each do |dimension|
      i += 1
      printf("#%d %s\n", i, dimension)
    end
  end
end

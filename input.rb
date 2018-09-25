class Input
  def initialize(renderer, mapping)
    @renderer = renderer
    @mapping = mapping
  end

  def start
    clear
    category = getCategory
    firstConvert = getConvertFrom(category)
    firstDimension = getConvertDimension(category, firstConvert)
    secondConvert = getConvertTo(category)
    secondDimension = getConvertDimension(category, secondConvert)
    printf("convert from (%s) to (%s)", firstDimension, secondDimension)
  end

  private

  def getConvertDimension(categoryName, convert)
    clear
    dimensions = @mapping['category'][categoryName][convert]
    max = dimensions.keys.length
    print("\n")
    printf("Choose the dimension (1 - %i): \n", max)
    @renderer.printKeys(dimensions.keys)

    selected = gets.chop.to_i
    if checkInput(selected, max)
      dimensions.keys[selected - 1]
    else
      getConvertDimension(categoryName, convert)
      clear
    end
  end

  def getConvertFrom(categoryName)
    clear
    categorieEntry = @mapping['category'][categoryName]
    max = categorieEntry.keys.length
    printf("Choose which to convert from (1 - %i): ", max)
    getConvert(categorieEntry, max)
  end

  def getConvertTo(categoryName)
    clear
    categorieEntry = @mapping['category'][categoryName]
    max = categorieEntry.keys.length
    printf("Choose which to convert to (1 - %i): ", max)
    getConvert(categorieEntry, max)
  end

  def getCategory
    clear
    categories = @mapping['category']
    max = categories.keys.length
    @renderer.printWelcome
    @renderer.printKeys(categories.keys)
    print("\n")

    printf("Choose your categorization (1 - %i): ", max)
    selected = gets.chop.to_i
    if checkInput(selected, max)
      categories.keys[selected - 1]
    else
      getCategory
      clear
    end
  end

  def checkInput(selected, max)
    returnValue = false
    if selected > max
      printf("Die Zahl ist zu groß.\n")
    else
      if selected <= 0
        printf("Die Zahl ist zu klein.\n")
      else
        returnValue = true
      end
    end
    returnValue
  end

  def getConvert(dimensions, max)
    print("\n")
    @renderer.printKeys(dimensions.keys)

    selected = gets.chop.to_i
    if checkInput(selected, max)
      dimensions.keys[selected - 1]
    else
      getConvert(dimensions, max)
      clear
    end
  end

  def clear
    print "\e[2J\e[f"
  end
end
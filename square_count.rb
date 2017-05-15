class File_data
  @@figures
  attr_accessor :file, :figures

  def initialize(f)
    @file = f if checkFile?(f)
  end

  def checkFile?(f)
    return File.file?(f)
  end

  def collectFigures
    @figures = Hash.new
    File.readlines(file).each do |line; figures |
      content = line.chomp!.gsub(/\s/, '').split(':')
      if @figures.has_key?(content[0])
        @figures[content[0]] = @figures[content[0]]+content[1].split(',')
      else
        @figures.merge!({content[0] => content[1].split(',')})
      end

    end
    @@figures = @figures
  end
end

class Figure

  attr_accessor :area, :params

  # constructor method
  def initialize(params)
    @params = params
  end


  def getCountSquare
    @@param.each do |val|
      self::setWidth = val
      self::getSquare
      self::printResult()
    end
  end

  def printResult()
    puts @area
  end

end

class Circle < Figure
attr_accessor :radius
  def getSquare(*param)
    @area = Math::PI * param[0].to_f**2
  end
end

file_input = ARGV[0]

file = File_data.new(file_input)
file.collectFigures()
file.figures.each do |key, value|
  if Object.const_defined?(key.capitalize)

    figure =Object.const_get(key.capitalize)
    figure = figure.new(value)
    #figure.getBlockParams()
    p figure.getSquare(2)

  end
end

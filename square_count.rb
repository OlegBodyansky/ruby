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
  @amount_params = 2
  attr_accessor :area, :params

  def self.amount_params
    @amount_params
  end

  def printParams()
    print "Used params: #{@params.join(',')} "
  end

  def printResult()
    puts "Count square: #{@area}"
  end
end

class Circle < Figure
  @amount_params = 1

  def getSquare()
    @area = Math::PI * @params[0].to_f ** 2
  end
end

class Square < Figure
  @amount_params = 2

  def getSquare()
    @area = @params[0].to_f * (!@params[1].nil? ? @params[1].to_f : @params[0].to_f)
  end
end

class Triangle < Figure
  @amount_params = 2

  def getSquare()
    @area = 0.5* @params[0].to_f * (!@params[1].nil? ? @params[1].to_f : @params[0].to_f)
  end
end

file_input = ARGV[0]

file = File_data.new(file_input)
file.collectFigures()
file.figures.each do |key, value|
  i=0
  if Object.const_defined?(key.capitalize)
    figure =Object.const_get(key.capitalize)
    figure = figure.new
    puts key.capitalize
    while i < value.length do
      figure.params= value.slice(i, figure.class.amount_params);
      figure.getSquare()
      figure.printParams()
      figure.printResult
      i+= figure.class.amount_params
    end

  end
end


circle = Circle.new
circle.getSquare([15])
circle.printResult







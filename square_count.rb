
class File_data
	@@figures
	attr_accessor :file, :figures
	
	def initialize(f)
		@file = f if checkFile(f)
	end
	
	def checkFile(f)
		return File.file?(f)
	end
	
	def collectFigures
		@figures = Hash.new
		File.readlines(file).each do |line; figures|
			content = line.chomp!.gsub(/\s/,'').split(':')
			if @figures.has_key?(content[0])
			@figures[content[0]] = @figures[content[0]]+content[1].split(',')
			else
			@figures.merge!({content[0]=>content[1].split(',')})
			end
			
		end
		@@figures = @figures 
	end
end

class Figure
 # constructor method
   def initialize(w,h)
      @width, @height = w, h
   end

   # accessor methods
   def getWidth
      @width
   end
   def getHeight
      @height
   end

   # setter methods
   def setWidth=(value)
      @width = value
   end
   
   def setHeight=(value)
      @height = value
   end

end

file_input = ARGV[0]

file = File_data.new(file_input)
file.collectFigures()
p file.figures

=begin
You can convert temperature using console paramters.
Converter supports string format divide whitespace or comma e.g.
	36c "23 f";
	36c,24F36.6c,23f;
	"36c, 24F 36.6c, 23F" 
=end

def convert_temp(temp, system)

  case system
    when 'c', 'C'
      temp_convert =  9.0/5.0*temp.to_f+32
      temp_system = 'F'
    when 'f', 'F'
      temp_convert = 5.0/9.0*(temp.to_f-32)
      temp_system = 'C'
    else
      temp_convert = 0.0
      temp_system =''
  end

  return "Temperature is #{temp_convert.round(2)} #{temp_system}"
end

re = /(\d+\.?\d*\s?)(c|C|f|F)/
params =  ARGV
temperature_list = Array.new() 

params.each do |param| 
	param.scan(re).each do |block|
	temperature_list.push(block)
	end
end

temperature_list.each do |str_temp, str |
puts "Get temperature: #{str_temp}#{str}"
puts convert_temp(str_temp, str)
end

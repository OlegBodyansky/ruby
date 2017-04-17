def convert_temp(temp, system)

  case system
    when 'C'
      temp_convert =  9.0/5.0*temp.to_f+32
      temp_system = 'F'
    when 'F'
      temp_convert = 5.0/9.0*(temp.to_f-32)
      temp_system = 'C'
    else
      temp_convert = 0.0
      temp_system =''
  end

  return "#{temp_convert.round(2)}#{temp_system}, "
  end
str_temperature = ''
file_input = ARGV[0]
File.readlines(file_input).each do |line|
  content = line.gsub(/\s/,'').split(',')
   content.each do |temp|
   str_temperature+=convert_temp(temp[0...-1], temp[-1])
   end
  str_temperature+="\n"
end
output = File.new("output.txt",'w+')
output.syswrite(str_temperature)
output.close






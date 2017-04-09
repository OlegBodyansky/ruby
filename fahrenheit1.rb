
def convert_temp(temp, system)
  temp_convert = 0.0
  temp_system =''
  unless system.match(/(c|C)/).nil?
    temp_convert =  9.0/5.0*temp.to_f+32
    temp_system = 'F'
  end
  unless system.match(/(f|F)/).nil?
    temp_convert = 5.0/9.0*(temp.to_f-32)
    temp_system = 'C'
  end
  return "Temperature is #{temp_convert.round(2)} #{temp_system}"
end

printf('Please, input temperature: ')
str_temp = gets.chomp
str_match = str_temp.match(/(\d+\.?\d*\s?)(c|C|f|F)/);

if str_temp.empty? || str_match.nil?
  abort('String doesn\'t include temperature string')
else
  p convert_temp(str_match[1], str_match[2])
end

str_temperature = ''
file_input = ARGV[0]
input = File.open(file_input,'a+')

(1..100).each do |num|
  str_temperature += rand(100).to_s + 'C'
  str_temperature += (num%10).zero? ? ",\n":', '
end
input.syswrite(str_temperature)
input.close

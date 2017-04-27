=begin
поменять название home_dir на current_dir
поменять по полному пути
поверка на скрытый файл
проверить на последний слешь так как файл может быть без расширения

=end
home_dir = Dir.pwd
File.readlines('dir_and_path.txt').each do |path|
  Dir.chdir(home_dir)
  path.chomp!
  arr_path =path.split(/[\/\\]/) - ['']
  arr_path.each do |val|
    if val.index('.') then
      File.open(val,'w').close
    else
      Dir.mkdir(val) unless Dir.exist?(val)
      Dir.chdir(val)
    end
  end

end


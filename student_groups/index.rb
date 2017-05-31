require_relative 'main_config'
require_relative 'classes'

connect  = Connection.new(MainConfig.config[:db_params])
people = Student.new()
people.connection = connect.connection

pep=  people.getGroupList('5a')
pep.each do |row|
  p row
end


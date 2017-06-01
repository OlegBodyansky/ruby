require_relative 'main_config'
require_relative 'classes'

param = ARGV[0]

connect  = Connection.new(MainConfig.config[:db_params])
people = Student.new()
people.connection = connect.connection
people.getGroupList(param)
people.printList

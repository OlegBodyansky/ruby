require 'mysql2'
class Connection
  attr_accessor :connection
  def initialize(db_params)
    @connection = Mysql2::Client.new(db_params);
  end
end

class People
  attr_accessor :name, :type, :age, :connection
  # def initialize(data)
  #   @name = data[:name]
  #   @type = data[:type]
  #   @age = data[:age]
  # end
  def getPeople()
    connection.query('Select * from people')
  end
end

class Student < People
  def getGroupList(group)

   @query = connection.prepare("select people.*, gr.* from people
inner join (
	select people_groups.people_id from groups
    left join people_groups on groups.id = people_groups.group_id
    where groups.name LIKE (?)
    )as gr  on people.id=gr.people_id ")
                @query.execute(group)
  end
end
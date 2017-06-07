class Database
  attr_accessor :db, :builder
    def initialize
      @db = Mysql2::Client.new(YAML.load_file('config.yml')['db'])
      @builder= QueryBuilder.new()
    end

    def query()
      @db.query(@builder.query_string)
    end
end

class QueryBuilder
  @@select = '*'
  attr_accessor :query_string
  def select(fields)
    @@select = fields
    self
  end

  def from(table)
    @from = table
    self
  end

  def all
    @query_string = "select #{@@select} from #{@from};"
  end

end

class People
  attr_accessor :name, :type, :age, :connection, :list
  def initialize
    @db = Database.new()
  end
  def getPeople()
    @db.builder.select('name, age').from('people').all
    @list = @db.query()
  end
  def printList()
    list.each{|row| p row}
  end
end

class Student < People

  def getGroupList(group)
    p @db.select('her')
    @list = @db.db.prepare("select people.*, gr.* from people inner join (select groups.name as group_name, people_groups.people_id from groups left join people_groups on groups.id = people_groups.group_id where groups.name LIKE (?) )as gr  on people.id=gr.people_id ").execute(group)
    #@list = @query.execute(group)
    #@list= @db.select().where().query()
  end

  def printList()
    list.each do |row|
      puts "Student: #{row['name']}, age: #{row['age']}"
    end
  end

end
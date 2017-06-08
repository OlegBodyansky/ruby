class Database
  attr_accessor :db
    def initialize
      @db = Mysql2::Client.new(YAML.load_file('config.yml')['db'])

    end

    def query(query_string)
      @db.query(query_string)
    end
end

class QueryBuilder

  attr_accessor :query_string
  def initialize
    @select = '*'
    @from =''
    @where = '1=1'
  end

  def select(fields)
    @select = fields
    self
  end

  def from(table)
    @from = table
    self
  end
  def andWhere(data ={})
    where_param =[]

     data.each{|key,val|
       val = "'#{val}'" if val.class == String
       where_param.push("#{key} = #{val}")
     }
    str  = where_param.join(' AND ')
    @where = str unless str.empty?
    self
  end
  def get
    @query_string = "select #{@select} from #{@from} where #{@where} ;"
  end

end

class People
  def initialize
    @db = Database.new
    @builder= QueryBuilder.new
    @builder.from('people')
  end

  def getPeople()
    @builder.select('name, age')
    @list = @db.query(@builder.get)
  end

  def printList()
    list.each do |row|
      puts "#{self.class}: #{row['name']}, age: #{row['age']}"
    end
  end

  def all()
    @list = @db.query(@builder.andWhere(:type=>self.class.to_s.downcase).get)
  end
end

class Student < People

end

class Teacher < People

end
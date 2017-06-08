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

  def getPeople
    @builder.select('name, age')
    @list = @db.query(@builder.get)
  end

  def printList
    list.each do |row|
      puts "#{self.class}: #{row['name']}, age: #{row['age']}"
    end
  end

  def all
    @list = @db.query(@builder.andWhere(:type=>self.class.to_s.downcase).get)
  end

  def find(id)
    return @row if !@row.nil? && @row[:id] == id
    @row = @db.query(
        @builder.
            andWhere(
                :id => id,
                :type => self.class.to_s.downcase
            ).get
    ).first
  end

  def groups
=begin
    SELECT * FROM test.people_groups
    inner join  test.groups
    on test.groups.id = test.people_groups.group_id
    WHERE test.people_groups.people_id = 2
=end
  p @builder.select( "groups.*").from("people_groups").
      andWhere("people_groups.people_id" => 2).get
  abort
  @db.query("SELECT test.groups.* FROM test.people_groups
    inner join  test.groups
    on test.groups.id = test.people_groups.group_id
    WHERE test.people_groups.people_id = 2").each
  end

end

class Student < People

end

class Teacher < People

end
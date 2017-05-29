require 'mysql2'

def print_block(people)
  people.each do |row|
    puts "Name #{row['name']} age #{row['age']} type #{row['type']}"
  end
end

def collectPeople (people)
  output = File.new("people.txt", 'a+')
  people.each do |row|
    output.syswrite(row)
  end
  output.close
end

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "test");


#4.1 selects all records from people table
$query_all = 'Select * from people'
# 4.2 selects only director
# 4.3 selects students
$query_by_type = "Select * from people where type LIKE ?"

# 4.4 selects the most young student
$query_youngest = 'Select * from people where type="student" and age = (select min(age)from people )'
#4.5 selects the most old teacher
$query_oldest = 'Select * from people where type="teacher" and age = (select max(age)from people )'
#4.9 deletes third record from the end (edited)
$query_delete = 'delete w FROM test.people  w
inner join (Select id from people order by id desc limit 2,1) as p on w.id=p.id'

puts 'selects all records from people table'
print_block(client.query($query_all))
puts 'selects the most young student'
print_block(client.query($query_youngest))
puts ' selects the most old teacher'
print_block(client.query($query_oldest))
puts ' 4.2 selects only director; 4.3 selects students'
statement = client.prepare($query_by_type)
print_block(statement.execute("director"))
print_block(statement.execute("student"))
puts '4.6 inserts you as a student'
client.query("insert into people(name, age, type) values('oleg', 30,'student')")
print_block(client.query("select * from people where name='oleg'"))
puts 'updates all cleaners who are older 60 to 59'
print_block(client.query("select * from people where type='cleaner'"))
client.query("update people set age=59 where type = 'cleaner' and age>60")
print_block(client.query("select * from people where type='cleaner'"))
#4.8 writes all people to file
collectPeople(client.query($query_all))

puts '4.9 deletes third record from the end (edited)'
print_block(client.query($query_all))
client.query($query_delete)
print_block(client.query($query_all))

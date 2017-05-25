class Time_extend < Time
  attr_accessor :date, :new_year


  def getLeaveDaysForNewYear
    @date = Time.now() if @date.nil?
    @new_year  = Time.new(@date.year+1)
    @total_seconds =  (@new_year - @date).to_i

    days = @total_seconds / (60 * 60*24)

    hours =  (@total_seconds / (60 * 60))% 60
    minutes = (@total_seconds / 60) % 60
    seconds = @total_seconds % 60
    "#{days} d #{ hours } h #{ minutes } m #{ seconds } s"
  end

end

time = Time_extend.new()

p time.getLeaveDaysForNewYear()


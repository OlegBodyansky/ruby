def getUserNumber
  printf("Try to guess a integer number: ")
  user_input = gets.chomp
  while (user_input.to_i.to_s != user_input) do
    printf "Try again. It looks like not  integer number: "
    user_input = gets.chomp
  end
  return user_input.to_i
end

def checkInput(guessed_number, input)
    guessed =0
      if guessed_number > input
        puts "Your number is less, than I guessed"
        end
      if guessed_number < input
        puts "Your number is greater, than I guessed"
      end

      if guessed_number == input
        puts "Your guessed!"
        guessed = 1
      end
  return guessed
end

attempt = ARGV[0]
ARGV.clear
abort('You lost parameter amount of attempt') if attempt.nil? || attempt.to_i ==0
guessed_number = rand(100)
guessed=0
attempt.to_i.times do
  user_number = getUserNumber
 guessed = checkInput(guessed_number, user_number)
  if ( guessed==1)
    break
  end

end

if (guessed == 0)
  puts "I guessed #{guessed_number}"
end
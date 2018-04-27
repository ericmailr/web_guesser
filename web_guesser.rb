require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@guesses_left = 5
@@reset = false
message = nil
get '/' do
	if @@reset
		reset
		@@reset = false
	end
	@@guesses_left -= 1
	guess = params["guess"]
	guess_result = check_guess(guess)
	message = guess_result[0]
	color = guess_result[1]
	if message.include?("Nailed it")
		message << " Number has been reset."
		@@reset = true
	elsif @@guesses_left == 0
		message = "Ya lose. Number has been changed."
		@@reset = true
	end
	if params["cheat"] == "true"
		message << " Hint: the number is #{@@secret_number}, cheater."
	end
	erb :index, :locals => {:color => color, :message => message}
end

def check_guess(guess)
	ret = ""
	if guess == nil
		return [ret, 'white']
	elsif guess.to_i > @@secret_number + 5
		return [ "Way too high!", 'red' ]
	elsif guess.to_i > @@secret_number
		return [ "Too high!", 'darksalmon' ]
	elsif guess.to_i < @@secret_number - 5
		return [ "Way too low!", 'red' ]
	elsif guess.to_i < @@secret_number
		return [ "Too low!", 'darksalmon' ]
	else
		return [ "Nailed it!\n\nThe SECRET NUMBER was #{@@secret_number}.", 'green' ]
	end	
end

def reset
	@@secret_number = rand(101)
	@@guesses_left = 5
end


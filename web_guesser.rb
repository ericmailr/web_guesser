require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
get '/' do
	guess = params["guess"]
	guess_result = check_guess(guess)
	message = guess_result[0]
	color = guess_result[1]
	erb :index, :locals => {:color => color, :message => message}
end

def check_guess(guess)
	ret = ""
	if guess == nil
		return [ret, 'white']
	elsif guess.to_i > SECRET_NUMBER + 5
		return [ "Way too high!", 'red' ]
	elsif guess.to_i > SECRET_NUMBER
		return [ "Too high!", 'darksalmon' ]
	elsif guess.to_i < SECRET_NUMBER - 5
		return [ "Way too low!", 'red' ]
	elsif guess.to_i < SECRET_NUMBER
		return [ "Too low!", 'darksalmon' ]
	else
		return [ "Nailed it!\n\nThe SECRET NUMBER was #{SECRET_NUMBER}.", 'green' ]
	end	
end

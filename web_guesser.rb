require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
get '/' do
	guess = params["guess"].to_i
	message = check_guess(guess)
	erb :index, :locals => {:message => message}
end

def check_guess(guess)
	ret = ""
	if guess > SECRET_NUMBER + 5
		ret << "Way too high!"
	elsif guess > SECRET_NUMBER
		ret << "Too high!"
	elsif guess < SECRET_NUMBER - 5
		ret << "Way too low!"
	elsif guess < SECRET_NUMBER
		ret << "Too low!"
	else
		ret << "Nailed it!\n\nThe SECRET NUMBER was #{SECRET_NUMBER}."
	end	
end

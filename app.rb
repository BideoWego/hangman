require 'sinatra'

require_relative 'resources/art.rb'
require_relative 'resources/words.rb'
require_relative 'lib/game.rb'

get '/'  do
	Game.words = $words
	Game.state = params

	if Game.playing
		erb :game
	else
		erb :menu
	end
end
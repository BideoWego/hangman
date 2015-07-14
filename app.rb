require 'sinatra'

set :public_folder, Proc.new { File.join(File.dirname(__FILE__), 'public') }

require_relative 'resources/art.rb'
require_relative 'resources/words.rb'
require_relative 'lib/game.rb'

get '/'  do
	Game.words = $words
	Game.state = params
	locals = {:base_url => request.url}
	view = (Game.playing) ? :game : :menu
	erb view, :locals => locals
end
class Game
	@@lives = 5

	class << self
		attr_accessor :words
		attr_accessor :state
		attr_accessor :index
		attr_accessor :lives
		attr_accessor :win
	end

	def self.icon(type)
		'<span class="glyphicon glyphicon-' + type + '" aria-hidden="true"></span>'
	end

	def self.playing
		if self.has_difficulty
			self.set_word
			self.won?
			self.damage
			return true
		else
			self.reset
			return false
		end
	end

	def self.hits
		hits = []
		self.guesses.each do |c|
			hits << c if self.word.include?(c)
		end
		hits
	end

	def self.misses
		misses = []
		self.guesses.each do |c|
			misses << c if not self.word.include?(c)
		end
		misses
	end

	def self.words
		@words
	end

	def self.state
		@state
	end

	def self.difficulty
		@state[:difficulty].to_i
	end

	def self.won?
		won = false
		if not progress.include?('_')
			self.win = won = true
		end
		won
	end

	def self.damage
		self.lives = @@lives - self.misses.size
	end

	def self.options
		alpha = ('a'..'z').to_a
		options = []
		if not self.guesses.empty?
			guesses = self.guesses
			alpha.each do |letter|
				options << letter if not guesses.include?(letter)
			end
		else
			options = alpha
		end
		options
	end

	def self.guesses(to_csv=false)
		guesses = []
		if self.state[:guesses] != nil
			self.state[:guesses].each_char do |c|
				guesses << c if c != ','
			end
		end
		if self.state[:guess] != nil
			guesses << self.state[:guess]
		end
		if to_csv
			guesses = guesses.join(',')
		end
		guesses
	end

	def self.progress
		guesses = self.guesses
		progress = ''
		word.each_char do |c|
			progress += (guesses.include?(c)) ? c : '_'
		end
		progress
	end

	def self.difficulties
		difficulties = []
			self.words.each_with_index do |array, i|
				difficulties << i if not array.empty?
			end
		difficulties
	end

	def self.word
		if self.has_index
			self.get_current
		else
			self.set_lives
			self.get_random
		end
	end

	private

		def self.set_lives
			self.lives = @@lives
		end

		def self.set_word
			self.word
		end

		def self.reset
			self.win = false
			self.index = nil
		end

		def self.has_difficulty
			(self.difficulty > 0) ? true : false
		end

		def self.has_index
			if self.index != nil
				return true
			else
				return false
			end
		end

		def self.get_random()
			difficulty = self.difficulty
			size = @words[difficulty].size
			self.index = rand(size)
			words = @words[difficulty].shuffle
			words[self.index]
		end

		def self.get_current()
			difficulty = self.difficulty
			@words[difficulty][self.index]
		end
end
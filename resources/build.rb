def get_array_and_max_length(file)
	array = []
	max_length = 0
	
	file = File.open(file)
	
	file.readlines.each_with_index do |line, i|
		word = line.gsub(/\n/, '').gsub(/\s/, '')
		array << word
		length = word.length
		max_length = (max_length > length) ? max_length : length
	end

	{
		:array => array,
		:max_length => max_length
	}
end

def to_indexed_difficulty(array, max_length)
	indexed_difficulty = []

	max_length.times do |i|
		indexed_difficulty.push([])
	end

	array.each do |word|
		indexed_difficulty[word.length - 1] << word
	end

	indexed_difficulty
end

def to_source(indexed)
	file = File.new('words.rb', 'w')
	file.puts "$indexed = ["
	indexed.each_with_index do |array, i|
		file.puts "\t["
		array.each_with_index do |word, j|
			word = "\t\t" + '"' + word + '"'
			word += ',' if j != array.size - 1
			file.puts word
		end
		(i != indexed.size - 1) ? file.puts("\t],"): file.puts("\t]")
	end
	file.puts "]"
	file.close
end

words = get_array_and_max_length('enable.txt')
indexed_difficulty = to_indexed_difficulty(words[:array], words[:max_length])
to_source(indexed_difficulty)
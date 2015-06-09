# [Hangman][game]

The classic game brought to life with Ruby, Sinatra, and Bootstrap 3.

Play the game [here][game] on Heroku.

## About the game

- Words
	* The game uses a library of words provided in `/resources/enable.txt`
	* This word list is used to populate an array `$words` in `/resources/words.rb`
	* This file and array are built using a small ruby script in `/resources/build.rb`
	* $words is an array of child arrays that contain words with string lengths equal to the value of the index of the child array in $words
- Difficulty
	* The difficulty selection is enabled and populated only with the index of child arrays that are not empty
	* When the user selects a difficulty, the Game object uses this integer to select a child array from $words
- Word
	* The word choosen for each game is selected randomly by a 2 fold method:
		1. Generating a random index using `rand()` with the size of the array as the argument
		1. Shuffling the word array before retrieving a word from it with the above random index
- State
	* The `Game` class in `/lib/game.rb` uses the Sinatra `params` object to determine the state of the game
	* The state keeps track of:
		+ The last guessed letter
		+ All other letter guesses
		+ Difficulty selected
- Scoring
	* Player lives are set directly equal to `5 - ${INCORRECT_GUESSES}`
	* The game is lost after 5 incorrect guesses are made
	* The game is won when all letters have been correctly guessed
- Art
	* Art work is completely ASCII and output in a `<pre>` tag to preserve white-space
	* The art work changes color from green to red with each lost life
- Hidden Cheat
	* The game is equipped with a hidden cheat to view the current word for debugging and fun of course

## Structure and design
	
- Routes
	* There is only 1 `GET` route used: `'/'`
	* The game is completely reliant on form input parameters being preserved in the URL
	* While `POST` would be more secure from tampering, I wanted to use `GET` as an exercise
- Ruby
	* While JavaScript could provide more interaction and indeed be used to run this game entirely, I chose specifically to not use it
	* The logic and calculations for this game are all delibrately written in Ruby
	

#### I hope you enjoy [Hangman][game]!

[Bideo Wego][bideowego]

[game]: https://bideowego-hangman.herokuapp.com
[bideowego]: http://bideowego.com/
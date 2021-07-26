# frozen_string_literal: true

require 'json'
require_relative 'display'
require_relative 'game_input'

# Plays a singular game of hangman
class Gameplay
  include Display
  include GameInput

  attr_accessor :save_game_name

  def initialize(
    codeword,
    progress = [],
    guessed_letters = [],
    incorrect_letters = [],
    save_game_name = ''
  )
    @codeword = codeword
    @progress = progress
    @guessed_letters = guessed_letters
    @incorrect_letters = incorrect_letters

    @save_game_name = save_game_name

    return unless progress.empty?

    codeword.length.times { progress.push('*') }
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'codeword' => @codeword,
      'progress' => @progress,
      'guessed_letters' => @guessed_letters,
      'incorrect_letters' => @incorrect_letters,
      'save_game_name' => @save_game_name
    }.to_json(*args)
  end

  def self.json_create(hash)
    new(hash['codeword'],
        hash['progress'],
        hash['guessed_letters'],
        hash['incorrect_letters'],
        hash['save_game_name'])
  end

  def play
    until finished?
      display(@progress, @incorrect_letters)

      letter_guess = letter_guess_input(@guessed_letters)
      return 'save' if letter_guess == '1'

      guess_reaction(letter_guess)
    end

    conclusion
  end

  def guess_reaction(letter_guess)
    if @codeword.include?(letter_guess)
      puts "\"#{letter_guess}\" is correct!"
      update_progress(letter_guess)
    else
      puts "\"#{letter_guess}\" is not correct!"
      @incorrect_letters.push(letter_guess)
    end

    @guessed_letters.push(letter_guess)
  end

  def update_progress(letter_guess)
    @codeword.split('').each_with_index do |letter, index|
      @progress[index] = letter_guess if letter == letter_guess
    end
  end

  def finished?
    return true if @incorrect_letters.length == 6
    return true unless @progress.include?('*')

    false
  end

  def conclusion
    display(@progress, @incorrect_letters)

    if @progress.include?('*')
      puts "\nYou didn't guess the word in time!"
      puts "The correct word was \"#{@codeword}\""
    else
      puts "\nYou guessed the word in time - Congrats!"
    end

    'finished'
  end
end

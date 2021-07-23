# frozen_string_literal: true

# Manages games of hangman with the option to save the game state
class Hangman
  def initialize
    create_pruned_wordlist
    @current_codeword = generate_codeword
  end

  def play
    # "Welcome to Hangman!"
    # Ask whether player wants to start a new game
    # Ask whether they would like to play again at the end
  end

  def gameloop
    # The game playing itself
    # Draw display
    # ask for a guess or whether to save or whether to exit
    # display whether correct or not
  end

  def create_pruned_wordlist
    return if File.exist?('pruned_wordlist.txt')

    words = File.open('5desk.txt', 'r').readlines
    words.map!(&:chop)

    pruned_words = words.reject { |word| word.length > 12 || word.length < 5 }
    pruned_words.reject! { |word| /[[:upper:]]/.match?(word) }

    File.open('pruned_wordlist.txt', 'w+') do |f|
      f.puts(pruned_words)
    end
  end

  def generate_codeword
    words = File.open('pruned_wordlist.txt', 'r').readlines
    words.sample.chop
  end
end

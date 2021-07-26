# frozen_string_literal: true

require_relative 'display'
require_relative 'gameplay'
require_relative 'game_input'

# Manages games of hangman with the option to save the game state
class Hangman
  include Display
  include GameInput

  def initialize
    create_pruned_wordlist
  end

  def start
    welcome

    gameloop

    goodbye
  end

  def gameloop
    case game_menu_input
    when 'new_game'
      play_game(Gameplay.new(generate_codeword))
    when 'load_game'
      load_game
    when 'quit_game'
      return
    end

    gameloop
  end

  def play_game(game_instance)
    played_game = game_instance.play

    case played_game
    when 'save'
      save_game(game_instance)
    when 'finished'
      delete_save(game_instance)
    end
  end

  def load_game
    puts "\nNo save games exist!" unless Dir.glob('game_saves/*.json').any?
    return unless Dir.glob('game_saves/*.json').any?

    existing_saves = Dir.entries('game_saves')
    existing_saves.delete('.')
    existing_saves.delete('..')

    file_to_load = "game_saves/#{load_game_input(existing_saves)}.json"

    loaded_file = File.read(file_to_load)

    game_instance = JSON.parse(loaded_file, create_additions: true)

    play_game(game_instance)
  end

  def save_game(game_instance)
    if game_instance.save_game_name == ''
      Dir.mkdir('game_saves') unless Dir.exist?('game_saves')

      existing_filenames = Dir.entries('game_saves')

      filename = save_name_input(existing_filenames)
      filestring = "game_saves/#{filename}.json"

      game_instance.save_game_name = filestring
    else
      filestring = game_instance.save_game_name
    end

    File.open(filestring, 'w') { |file| file.write(JSON.pretty_generate(game_instance)) }
  end

  def delete_save(game_instance)
    return unless File.exist?(game_instance.save_game_name)

    File.delete(game_instance.save_game_name)
  end

  def create_pruned_wordlist
    return if File.exist?('pruned_wordlist.txt')

    words = File.open('5desk.txt', 'r').readlines
    words.map!(&:chop)

    pruned_words = words.reject { |word| word.length > 12 || word.length < 5 }
    pruned_words.reject! { |word| /[[:upper:]]/.match?(word) }

    File.open('pruned_wordlist.txt', 'w') do |f|
      f.puts(pruned_words)
    end
  end

  def generate_codeword
    words = File.open('pruned_wordlist.txt', 'r').readlines
    words.sample.chop
  end
end

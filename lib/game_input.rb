# frozen_string_literal: true

# Function for every input we need
module GameInput
  def letter_guess_input(guessed_letters)
    print "\nGuess a letter or input \"1\" to save and exit\n> "
    input = gets.chomp.downcase

    return input if input.match?(/^[a-z1]{1}$/) && !guessed_letters.include?(input)

    if guessed_letters.include?(input)
      puts "You have already guessed \"#{input}\"!  Please try again."
    else
      puts 'Invalid input!'
    end

    letter_guess_input(guessed_letters)
  end

  def game_menu
    puts "\nWould you like to:"
    puts '1) Start a new game.'
    puts '2) Load a saved game.'
    puts '3) Quit hangman.'
  end

  def game_menu_input
    options = { '1' => 'new_game', '2' => 'load_game', '3' => 'quit_game' }
    game_menu
    print '> '

    input = gets.chomp.downcase

    return options[input] unless options[input].nil?

    puts 'Invalid input!'
    game_menu_input
  end

  def save_name_input(existing_filenames)
    print "\nPlease enter a name for this save game, it cannot have any spaces in it.\n> "

    input = gets.chomp

    if !input.match?(/^\S+$/)
      puts 'Invalid input - cannot have any spaces in it!'
    elsif existing_filenames.include?("#{input}.json")
      puts 'This name already exists as a save, please enter a unique name!'
    else
      return input
    end

    save_name_input(existing_filenames)
  end

  def save_games_list(existing_saves)
    options = {}

    existing_saves.each_with_index do |filename, index|
      options[(index + 1).to_s] = File.basename(filename, File.extname(filename))
      puts "#{index + 1}) #{options[(index + 1).to_s]}"
    end

    options
  end

  def load_game_input(existing_saves)
    puts "\nPlease select a file:"
    options = save_games_list(existing_saves)
    print '> '

    input = gets.chomp

    return options[input] unless options[input].nil?

    puts 'Invalid input!'
    load_game_input(existing_saves)
  end
end

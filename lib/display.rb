# frozen_string_literal: true

# Functions relating to displaying the game of Hangman
module Display
  HANGMAN_STAGE0 = <<~HEREDOC
      +---+
      |   |
          |
          |
          |
          |
    =========
  HEREDOC

  HANGMAN_STAGE1 = <<~HEREDOC
      +---+
      |   |
      o   |
          |
          |
          |
    =========
  HEREDOC

  HANGMAN_STAGE2 = <<~HEREDOC
      +---+
      |   |
      o   |
      |   |
          |
          |
    =========
  HEREDOC

  HANGMAN_STAGE3 = <<~HEREDOC
      +---+
      |   |
      o   |
     /|   |
          |
          |
    =========
  HEREDOC

  HANGMAN_STAGE4 = <<~HEREDOC
      +---+
      |   |
      o   |
     /|\\  |
          |
          |
    =========
  HEREDOC

  HANGMAN_STAGE5 = <<~HEREDOC
      +---+
      |   |
      o   |
     /|\\  |
     /    |
          |
    =========
  HEREDOC

  HANGMAN_STAGE6 = <<~HEREDOC
      +---+
      |   |
      o   |
     /|\\  |
     / \\  |
          |
    =========
  HEREDOC

  HANGMAN_STAGES = [
    HANGMAN_STAGE0,
    HANGMAN_STAGE1,
    HANGMAN_STAGE2,
    HANGMAN_STAGE3,
    HANGMAN_STAGE4,
    HANGMAN_STAGE5,
    HANGMAN_STAGE6
  ].freeze

  WELCOME = <<~HEREDOC

    ====================================
             Welcome to Hangman
    ====================================

  HEREDOC

  def welcome
    puts WELCOME
  end

  def goodbye
    puts "\nGoodbye!"
  end

  def display(progress, incorrect_letters)
    puts "\n#{HANGMAN_STAGES[incorrect_letters.length]}"
    puts ">> #{progress.join(' ')}"
    puts "Incorrect letter(s): \"#{incorrect_letters.join('", "')}\"." unless incorrect_letters == []
  end
end

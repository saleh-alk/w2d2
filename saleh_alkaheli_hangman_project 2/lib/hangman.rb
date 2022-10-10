class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index { |ele, i| arr << i if ele == char}
    arr
  end

  def fill_indices(char, arr)
    arr.each {|i| @guess_word[i] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      puts "that has already been attempted"
      false
    else

      @attempted_chars << char
      if get_matching_indices(char) == []
        @remaining_incorrect_guesses -= 1
      else
        fill_indices(char, get_matching_indices(char))
      end

      true
    end
  end

  def ask_user_for_guess
    puts 'Enter a char:'
    guess = gets.chomp
    return try_guess(guess)
  end

  def win?
    if @guess_word.join('') == @secret_word
      print 'WIN'
      true
    else
      false
    end
  end


  def lose?
    if @remaining_incorrect_guesses == 0
      puts 'LOSE'
      true
    else
      false
    end
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      true
    else
      false
    end
  end

end

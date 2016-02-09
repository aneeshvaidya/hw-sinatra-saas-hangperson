class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word 
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @game_state = :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    
    if letter.nil? or /[^a-zA-Z]/.match(letter) or letter.empty?
      raise ArgumentError.new("Invalid argument.")
    end
    letter = letter.downcase
    if @word.include? letter
      if !@guesses.include? letter
        @guesses += letter
      else
        false
      end
    else
      if !@wrong_guesses.include? letter
        @wrong_guesses += letter
      else
        false
      end
    end
  end
  
  def word_with_guesses
    word = ''
    @word.each_char do |letter|
      if @guesses.include? letter
        word += letter
      else
        word += '-'
      end
    end
    word
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      @game_state = :lose
    else
      word = ''
      @word.each_char do |letter|
        if @guesses.include? letter
          word += letter
        end
      end
      if @word == word
        @game_state = :win
      else
        @game_state = :play
      end
    end
    @game_state
  end
  
  
end

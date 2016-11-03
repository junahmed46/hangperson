class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if letter.nil? or letter.length == 0 or not letter=~/[a-z]/i
      raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  end
  
  def word_with_guesses
    result=''
    @word.each_char do |letter|
      if @guesses.include? letter
        result << letter
      else
        result << '-'
      end
    end
    result
  end
  
  def check_win_or_lose
    return :win if @word == word_with_guesses
    return :lose if @wrong_guesses.length == 7
    :play
  end
  
end
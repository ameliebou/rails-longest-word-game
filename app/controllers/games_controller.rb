require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    array = ('a'..'z').to_a
    8.times do
      @letters << array.sample(1)
    end
    @letters.flatten!
    session[:score] = 0 unless session.key?(:score)
    @score = session[:score]
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    if check_grid(@word) && check_word(@word)
      @result = 'Great job!'
      @part_score = @word.length
    elsif check_grid(@word)
      @result = "Sorry, \'#{@word}\' isn\'t a valid word"
      @part_score = 0
    else
      @result = "Sorry, \'#{@word}\' isn\'t in the grid"
      @part_score = 0
    end
    session[:score] += @part_score

  end

  def check_grid(word)
    word_array = word.split('')
    ltrs = @letters.dup
    word_array.each do |letter|
      if ltrs.include?(letter)
        ltrs.delete_at(ltrs.index(letter))
      else
        return false
      end
    end
    true
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionary = JSON.parse(open(url).read)
    return dictionary["found"]
  end

  private

  def store_score

  end
end

require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    letters = ('a'..'z').to_a
    @letters = letters.sample(10)
  end

  def score
    @answer = params[:answer].downcase
    @grid = params[:grid].split
    @parse_result = parsing(@answer)
    @filtered_result = game_answer(@parse_result, @answer)
    @response = check_include
  end

  private

  def parsing(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = URI.open(url).read
    JSON.parse(serialized)
  end

  def game_answer(parsing, answer)
    if parsing["found"] == false
      "Sorry but #{answer} doesn't seem to be an English word."
    end
  end

  def check_include
    array = @answer.chars.map do |letter|
      @grid.join.include?(letter)
    end
    array.include?(false) ? false : true
  end

end

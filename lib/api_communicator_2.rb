require 'rest-client'
require 'json'
require 'pry'

class Character
  attr_accessor :films,:name

  def initialize(person)
    @name = person["name"]
    @films_url = person["films"]
    @films = @films_url.map do |film|
      JSON.parse(RestClient.get(film))["title"]
    end
  end

  def prints_films
    @films.each_with_index do |film,index|
      puts "#{index+1}. #{film}"
    end
  end


end

def get_character(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the specific character's hash
  character_hash["results"].each do |person|
    if person["name"] == character
      return person
    else
      if JSON.parse(RestClient.get(character_hash["next"])) != "null"
        character_hash = JSON.parse(RestClient.get(character_hash["next"]))
        character_hash["results"].each do |person|
          if person["name"] == character
            return person
          end
        end
      end
      # how to iterate through pages
    end
  end
end

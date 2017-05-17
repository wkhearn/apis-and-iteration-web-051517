require 'rest-client'
require 'json'
require 'pry'

def get_character(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the specific character's hash
  result = nil
  character_hash["results"].each do |person|
    if person["name"] == character
      #binding.pry
      return result = person
    else
      if JSON.parse(RestClient.get(character_hash["next"])) != "null"
        #binding.pry
        character_hash = JSON.parse(RestClient.get(character_hash["next"]))
        character_hash["results"].each do |person|
          if person["name"] == character
          #binding.pry
            return result = person
          end
        end
      end
      # how to iterate through pages
    end
  end
  result
end

def get_character_movies_from_api(character)
  #make the web request
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')
  # character_hash = JSON.parse(all_characters)
  #
  # # iterate over the character hash to find the collection of `films` for the given
  # #   `character`
  # result = nil
  # character_hash["results"].each do |person|
  #   if person["name"] == character
  #     result = person
  #   end
  # end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  #binding.pry
  get_character(character)["films"].collect do |film|
    JSON.parse(RestClient.get(film))
  end


  #result_films = result["films"]
  # result_films.collect do |film|
  #   #binding.pry
  #   JSON.parse(RestClient.get(film))
  # end
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |film,index|
    puts "#{index+1}. #{film["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

require_relative "../lib/api_communicator_2.rb"

def welcome
  # puts out a welcome message here!
  puts "Welcome to our Star Wars lab"
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp

end

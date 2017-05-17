require 'pry'
#!/usr/bin/env ruby

#require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../lib/api_communicator_2.rb"

welcome
character = get_character_from_user

char = Character.new(get_character(character))
char.prints_films

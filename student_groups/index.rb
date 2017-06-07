require 'yaml'
require 'mysql2'
require_relative 'classes'
config= YAML.load_file 'config.yml'
param = ARGV[0]
people = People.new()
people.getPeople
people.printList

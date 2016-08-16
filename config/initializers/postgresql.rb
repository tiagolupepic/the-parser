require 'erb'
require 'active_record'
database = ERB.new(File.read("config/database.yml")).result
config = YAML.load(database)[ENV['RACK_ENV']]
ActiveRecord::Base.establish_connection(config)

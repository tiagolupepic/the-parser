require 'rubygems'
require 'bundler/setup'

Bundler.require

AppEnv = ENV['RACK_ENV'] || 'development'

[
  'config/initializers/',
  'app/helpers/',
  'app/services/',
  'app/models/',
  'app/api',
  'app'
].each do |path|
  rbfiles = File.join './', path, '*.rb'
  Dir.glob(rbfiles).each { |file| require file }
end

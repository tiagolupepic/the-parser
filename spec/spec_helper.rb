ENV["RACK_ENV"] = 'test'

require File.expand_path("../../config/boot", __FILE__)
require 'rack/test'
require 'factory_girl'
require 'database_cleaner'
require 'faker'
require 'vcr'


FactoryGirl.factories.clear
FactoryGirl.definition_file_paths = ['spec/factories']
FactoryGirl.find_definitions

Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

ActionMailer::Base.delivery_method = :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  config.color = true
  config.tty   = true
  config.order = "random"

  def app
    TheParser
  end

  def response
    last_response
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end

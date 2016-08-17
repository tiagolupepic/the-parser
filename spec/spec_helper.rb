ENV["RACK_ENV"] = 'test'

require File.expand_path("../../config/boot", __FILE__)
require 'shoulda/matchers'
require 'rack/test'
require 'factory_girl'
require 'database_cleaner'
require 'faker'
require 'vcr'


FactoryGirl.factories.clear
FactoryGirl.definition_file_paths = ['spec/factories']
FactoryGirl.find_definitions

Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
  config.include Shoulda::Matchers::ActiveModel,  type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model

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

  def headers(params = {})
    header = {
      "CONTENT_TYPE" => "application/json",
    }
    header.merge!({ 'rack.input' => StringIO.new(params.to_json) }) if params.present?
    header
  end
end

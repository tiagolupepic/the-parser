require 'spec_helper'

RSpec.describe TheParser do
  describe 'GET /' do
    it 'should respond with message' do
      get '/', {}, headers
      expect(json_response['name']).to eq 'The Parser Api'
    end

    it 'should respond with status 200' do
      get '/', {}, headers
      expect(response.status).to eq 200
    end
  end
end

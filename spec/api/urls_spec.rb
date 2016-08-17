require 'spec_helper'

RSpec.describe Urls do
  let(:request_headers) { headers(params) }
  let(:params) { }

  describe 'GET /' do
    it 'should respond with urls' do
      get '/urls', {}, request_headers
      expect(response.status).to eq 200
    end
  end

  describe 'POST /' do
    it 'should return status 200' do
      post '/urls', {}, request_headers
      expect(response.status).to eq 201
    end
  end
end

require 'spec_helper'

RSpec.describe Urls do
  let(:request_headers) { headers(params) }
  let(:params) { }

  describe 'GET /' do
    before do
      create :url_content
    end

    it 'should respond with status 200' do
      get '/urls', {}, request_headers
      expect(response.status).to eq 200
    end

    it 'should return array urls' do
      get '/urls', {}, request_headers
      expect(json_response.size).to eq 1
    end

    it 'should decorate urls' do
      get '/urls', {}, request_headers

      url = json_response.first

      expect(url.keys).to eq ['id', 'url', 'h1', 'h2', 'h3', 'links']
    end

    it 'should respond with paging headers' do
      get '/urls', {}, request_headers

      expect(response.headers['X-Total-Pages']).to eq '1'
      expect(response.headers['X-Total-Count']).to eq '1'
      expect(response.headers['X-Per-Page']).to    eq '10'
    end

    context 'paginate' do
      let(:params) { { page: 2 } }

      it 'should respond with status 200' do
        get '/urls', {}, request_headers
        expect(response.status).to eq 200
      end

      it 'should return empty urls' do
        get '/urls', {}, request_headers
        expect(json_response.size).to eq 0
      end
    end
  end

  describe 'POST /' do
    let(:params) { { url: url } }

    context 'valid url', vcr: true do
      let(:url) { 'http://guides.rubyonrails.org/routing.html' }

      it 'should run UrlContentService' do
        post '/urls', {}, request_headers
        expect(UrlContent.count).to eq 1
      end

      it 'should return status 201' do
        post '/urls', {}, request_headers
        expect(response.status).to eq 201
      end

      it 'should use decorator' do
        post '/urls', {}, request_headers
        expect(json_response.keys).to eq ['id', 'url', 'h1', 'h2', 'h3', 'links']
      end
    end

    context 'raise invalid url' do
      let(:url) { nil }

      it 'should run UrlContentService' do
        post '/urls', {}, request_headers
        expect(json_response['errors'].size).to  eq 1
        expect(json_response['errors'].first).to eq 'This URL is not valid.'
      end

      it 'should return status 422' do
        post '/urls', {}, request_headers
        expect(response.status).to eq 422
      end
    end
  end
end

require 'spec_helper'

RSpec.describe UrlContentDecorator do
  let(:model)  { create :url_content }
  let(:result) { subject.as_json }

  subject { described_class.new(model) }

  it { expect(described_class.ancestors).to include(Forwardable) }

  describe '#as_json' do
    it 'should parse json' do
      expect(result[:id]).to    eq model.id
      expect(result[:url]).to   eq 'http://www.google.com'
      expect(result[:h1]).to    eq ['This is one header', 'Second h1 tag']
      expect(result[:h2]).to    eq ['Header h2', 'Second h2 tag']
      expect(result[:h3]).to    eq ['Another h3 header']
      expect(result[:links]).to eq ['http://www.bing.com']
    end

    context 'with basic attributes' do
      let(:model) { create :url_content, headers_two: [], headers_three: [], links: [] }

      it 'should parse json' do
        expect(result[:id]).to    eq model.id
        expect(result[:url]).to   eq 'http://www.google.com'
        expect(result[:h1]).to    eq ['This is one header', 'Second h1 tag']
        expect(result[:h2]).to    eq []
        expect(result[:h3]).to    eq []
        expect(result[:links]).to eq []
      end
    end
  end
end

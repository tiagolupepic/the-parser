require 'spec_helper'

RSpec.describe UrlContentService do
  subject { described_class.new(url) }

  describe '#run' do
    context 'with blank url' do
      let(:url) { nil }

      it 'should not create UrlContent' do
        subject.run

        expect(UrlContent.count).to eq 0
      end

      it 'should not raise error' do
        expect { subject.run }.to_not raise_error
      end
    end

    context 'with valid url' do
      let(:url) { 'http://guides.rubyonrails.org/routing.html' }

      it 'should create UrlContent' do
        subject.run

        expect(UrlContent.count).to eq 1
      end

      it 'should assign params' do
        subject.run

        url = UrlContent.first

        expect(url.name).to               eq 'http://guides.rubyonrails.org/routing.html'
        expect(url.headers_one).to        eq ['Guides.rubyonrails.org']
        expect(url.headers_two).to        eq ['Rails Routing from the Outside In']
        expect(url.headers_three.size).to eq 7
        expect(url.links.size).to         eq 112
      end

      it 'should assign links urls' do
        subject.run

        url = UrlContent.first

        expect(url.links.first).to eq 'http://rubyonrails.org/'
        expect(url.links.last).to  eq 'https://creativecommons.org/licenses/by-sa/4.0/'
      end
    end

    context 'with invalid url' do
      let(:url) { 'guides.rubyonrails.org/routing.html' }


      it 'should not create UrlContent' do
        subject.run

        expect(UrlContent.count).to eq 0
      end

      it 'should not raise error' do
        expect { subject.run }.to_not raise_error
      end

      context 'and with http but invalid domain' do
        let(:url) { 'http://fake' }

        it 'should not create UrlContent' do
          subject.run

          expect(UrlContent.count).to eq 0
        end

        it 'should not raise error' do
          expect { subject.run }.to_not raise_error
        end
      end
    end

    context 'with url shortener' do
      let(:url) { 'http://bit.ly/1ww7mOQ' }

      it 'should create UrlContent' do
        subject.run

        expect(UrlContent.count).to eq 1
      end

      it 'should assign params' do
        subject.run

        url = UrlContent.first

        expect(url.name).to               eq 'http://guides.rubyonrails.org/routing.html'
        expect(url.headers_one).to        eq ['Guides.rubyonrails.org']
        expect(url.headers_two).to        eq ['Rails Routing from the Outside In']
        expect(url.headers_three.size).to eq 7
        expect(url.links.size).to         eq 112
      end
    end
  end
end

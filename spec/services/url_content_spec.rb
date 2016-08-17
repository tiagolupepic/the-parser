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

    context 'with url from google (redirect)' do
      let(:url) { 'http://www.indeed.com/rc/clk?jk=9b8104db56fc49ce&fccid=b8ada337c2ed4289' }

      it 'should create UrlContent' do
        subject.run

        expect(UrlContent.count).to eq 1
      end

      it 'should assign params' do
        subject.run

        url = UrlContent.first

        expect(url.name).to          eq 'http://cbscorporation.jobs/new-york-ny/sports-anchor/2119543DE34D4928A30422726AC73AB3/job/?utm_campaign=Indeed&vs=1554&utm_medium=Job%20Aggregator&utm_source=Indeed-DE'
        expect(url.headers_one).to   eq ['CBS Corporation Jobs']
        expect(url.headers_two).to   eq ['CBS Careers']
        expect(url.headers_three).to eq ['CBS Corporation Sports Anchor in New York, New York', 'Share', 'Current Search Criteria']
        expect(url.links.size).to    eq 95
      end
    end
  end
end

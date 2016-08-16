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
    end

    context 'with invalid url' do
    end

    context 'with url shortener' do
    end
  end
end

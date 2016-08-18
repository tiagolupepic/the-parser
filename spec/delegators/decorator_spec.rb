require 'spec_helper'

RSpec.describe DecoratorDelegator do
  subject { described_class.new(model) }

  describe '#run' do
    let(:result) { subject.run }

    context 'with Hash' do
      let(:model) { { name: 'Parser API' } }

      it 'should decorate' do
        expect(result[:name]).to eq 'Parser API'
      end
    end

    context 'with Array' do
      let(:model) { ['Parser API'] }

      it 'should decorate' do
        expect(result).to eq ['Parser API']
      end
    end

    context 'with UrlContent model' do
      let(:model) { create :url_content }

      it 'should decorate with decorator' do
        expect(result.class).to eq UrlContentDecorator
      end
    end
  end
end

# frozen_string_literal: true

require File.expand_path 'spec_helper.rb', __dir__

describe Stock do
  subject(:stock) { described_class }

  describe '#initialize' do
    before do
      stub_const('ARGV', cl_params)
    end

    context 'when with all correct command line params' do
      let(:cl_params) do
        ['--stock', 'ASTOCK', '--start', '01.01.2018', '--end', '21.04.2018']
      end

      it 'should parse the stock correctly' do
        expect(stock.new.options[:stock]).to eq('ASTOCK')
      end

      it 'should parse the start date correctly' do
        expect(stock.new.options[:start_date].to_s).to eq('2018-01-01')
      end

      it 'should parse the end date correctly' do
        expect(stock.new.options[:end_date].to_s).to eq('2018-04-21')
      end
    end

    context 'when with correct stock and start command params' do
      let(:cl_params) do
        ['--stock', 'ASTOCK', '--start', '01.01.2018']
      end

      it 'should parse the end date correctly' do
        expect(stock.new.options[:end_date].to_s).to eq(Date.today.to_s)
      end
    end
  end
end

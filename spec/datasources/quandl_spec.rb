# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

module Datasources
  describe Quandl do
    subject(:quandl) do
      described_class.new('AAPL', Date.parse('2018-01-01'),
                          Date.parse('2018-01-05'))
    end

    describe '#pull_data' do
      let(:response) do
        instance_double('response', parsed_response: {}, code: 200)
      end
      let(:quandl_secrets) { { 'api_key' => 'an_api_key' } }

      before do
        allow(YAML).to receive(:load_file).and_return(quandl_secrets)
        allow(HTTParty).to receive(:get).and_return(response)
      end

      it 'pulls data from quandl' do
        expect(quandl.pull_data).to eq([])
        expect(HTTParty).to have_received(:get)
          .with('https://www.quandl.com/api/v3/datasets/EOD/AAPL.json?start_'\
            'date=2018-01-01&end_date=2018-01-05&api_key=an_api_key&order=asc')
      end
    end
  end
end

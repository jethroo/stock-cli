# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

describe Quandl do
  subject(:quandl) do
    described_class.new('AAPL', Date.parse('2018-01-01'),
                        Date.parse('2018-01-05'))
  end

  describe '#pull_data' do
    let(:response) { instance_double('response', parsed_response: {}) }

    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it 'pulls data from quandl' do
      expect(quandl.pull_data).to eq(nil)
      expect(HTTParty).to have_received(:get)
        .with('https://www.quandl.com/api/v3/datasets/EOD/AAPL.json?start_date'\
          '=2018-01-01&end_date=2018-01-05&api_key=cx9v_iDQveQ81HJesPzQ'\
          '&order=asc')
    end
  end
end

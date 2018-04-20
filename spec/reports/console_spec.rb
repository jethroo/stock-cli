# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

describe Console do
  subject(:console) do
    described_class.new('data' => data)
  end

  describe '#generate_report' do
    let(:data) do
      [
        ['day1', nil, 'high1', 'low1', 'close1'],
        ['day2', nil, 'high2', 'low2', 'close2'],
        ['day3', nil, 'high3', 'low3', 'close3']
      ]
    end

    it 'prints a summary for each day' do
      allow(console).to receive(:color_puts)
      console.generate_report
      expect(console).to have_received(:color_puts).exactly(3).times
    end
  end
end

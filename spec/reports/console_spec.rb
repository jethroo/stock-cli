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

    context 'day summary' do
      before do
        allow(console).to receive(:color_puts)
        allow(console).to receive(:first_drawdowns)
        allow(console).to receive(:maximum_drawdown)
        allow(console).to receive(:return_summary)
      end

      it 'printed for each day' do
        console.generate_report
        expect(console).to have_received(:color_puts).exactly(3).times
      end
    end

    context 'drawdowns summary' do
      let(:drawdown) { instance_double('drawdown', drawdowns: []) }

      before do
        allow(console).to receive(:color_puts)
        allow(Drawdown).to receive(:new).and_return(drawdown)
      end

      it 'generated from Drawdown class' do
        console.generate_report
        expect(Drawdown).to have_received(:new)
      end
    end
  end
end

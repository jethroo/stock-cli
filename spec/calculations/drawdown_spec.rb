# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

module Calculations
  describe Drawdown do
    subject(:drawdown) { described_class.new(dataset) }

    let(:day_1) do
      Models::DayEntry.new(
        date: '2018-01-02', open: nil, high: 172.3, low: 169.26, close: nil
      )
    end

    let(:day_2) do
      Models::DayEntry.new(
        date: '2018-01-03', open: nil, high: 174.55, low: 171.96, close: nil
      )
    end

    # changed from sample data to cover lowest before new high case
    let(:day_3) do
      Models::DayEntry.new(
        date: '2018-01-04', open: nil, high: 173.47, low: 168.08, close: nil
      )
    end

    let(:day_4) do
      Models::DayEntry.new(
        date: '2018-01-05', open: nil, high: 175.37, low: 173.05, close: nil
      )
    end

    describe '#drawdowns' do
      let(:dataset) { [day_1, day_2, day_3, day_4] }

      it 'should find the drawdows correctly' do
        expect(drawdown.drawdowns.count).to eq(4)
        expect(drawdown.drawdowns[0].percentage).to be_within(0.001).of(1.8)
        expect(drawdown.drawdowns[1].percentage).to be_within(0.001).of(1.5)
        expect(drawdown.drawdowns[2].percentage).to be_within(0.001).of(3.8)
        expect(drawdown.drawdowns[3].percentage).to be_within(0.001).of(1.3)
      end
    end
  end
end

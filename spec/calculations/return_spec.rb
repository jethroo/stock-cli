# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

module Calculations
  describe Return do
    subject(:return_calculation) { described_class.new(dataset) }

    let(:day_1) do
      Models::DayEntry.new(
        date: '2018-01-02', open: 161.12, high: 172.3, low: 169.26, close: 170.2
      )
    end

    let(:day_2) do
      Models::DayEntry.new(
        date: '2018-01-03', open: 171.12, high: 174.5, low: 171.9, close: 176.55
      )
    end

    describe '#return_summary' do
      let(:dataset) { [day_1, day_2] }

      it 'should calculate return correctly' do
        expect(return_calculation.return_summary.percentage)
          .to be_within(0.001).of(9.6)
      end
    end
  end
end

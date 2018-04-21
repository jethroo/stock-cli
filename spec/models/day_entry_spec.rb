# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

module Models
  describe DayEntry do
    subject(:day_entry) { described_class.new(day_report) }

    describe 'initialize' do
      let(:day_report) do
        {
          date: 'date', open: 'open',
          high: 'high', low: 'low',
          close: 'close'
        }
      end

      %w[date open high low close].each do |attr|
        it "correctly initializes the entry for #{attr}" do
          expect(day_entry.public_send(attr)).to eq(attr)
        end
      end
    end
  end
end

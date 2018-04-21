# frozen_string_literal: true

require File.expand_path '../spec_helper.rb', __dir__

module Reports
  describe Console do
    subject(:console) do
      described_class.new(dataset)
    end

    describe '#generate_report' do
      let(:dataset) do
        [
          Models::DayEntry.new(sample_data_entry(1)),
          Models::DayEntry.new(sample_data_entry(2)),
          Models::DayEntry.new(sample_data_entry(3))
        ]
      end

      context 'day summary' do
        before do
          allow(console).to receive(:color_puts)
          allow(console).to receive(:put_seperator_line)
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
          allow(console).to receive(:put_seperator_line)
          allow(console).to receive(:maximum_drawdown)
          allow(console).to receive(:return_summary)
          allow(Calculations::Drawdown).to receive(:new).and_return(drawdown)
        end

        it 'generated from Drawdown class' do
          console.generate_report
          expect(Calculations::Drawdown).to have_received(:new)
        end
      end
    end

    def sample_data_entry(number)
      {
        date: "day#{number}", open: "open#{number}",
        high: "high#{number}", low: "low#{number}",
        close: "close#{number}"
      }
    end
  end
end

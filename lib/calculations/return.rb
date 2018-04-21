# frozen_string_literal: true

module Calculations
  # class for calculating the return value from a dataset
  class Return
    attr_reader :dataset

    Struct.new('ReturnSummary',
               :return_value, :percentage, :start_value, :start_date,
               :end_value, :end_date)

    def initialize(dataset)
      @dataset = dataset
    end

    def return_summary
      return unless dataset
      build_summary(
        [
          (dataset.last.close - dataset.first.open).round(4),
          return_in_percent(dataset.last.close, dataset.first.open),
          dataset.first.open, dataset.first.date,
          dataset.last.close, dataset.last.date
        ]
      )
    end

    private

    def build_summary(values)
      Struct::ReturnSummary.new.tap do |summary|
        summary.return_value = values[0]
        summary.percentage = values[1]
        summary.start_value = values[2]
        summary.start_date = values[3]
        summary.end_value = values[4]
        summary.end_date = values[5]
      end
    end

    def return_in_percent(high, low)
      (high / low * 100 - 100).round(1)
    end
  end
end

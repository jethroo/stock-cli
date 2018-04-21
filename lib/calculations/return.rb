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
      build_summary
    end

    private

    def return_value
      (dataset.last.close - dataset.first.open).round(4)
    end

    def return_percent
      (dataset.last.close / dataset.first.open * 100 - 100).round(1)
    end

    def build_summary
      Struct::ReturnSummary.new.tap do |summary|
        summary.return_value = return_value
        summary.percentage = return_percent
        summary.start_value = dataset.first.open
        summary.start_date = dataset.first.date
        summary.end_value = dataset.last.close
        summary.end_date = dataset.last.date
      end
    end
  end
end

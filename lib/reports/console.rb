# frozen_string_literal: true

require_relative '../calculations/drawdown'

module Reports
  # simple console reporter
  class Console
    attr_reader :dataset

    def initialize(dataset)
      @dataset = dataset
    end

    def generate_report
      return unless dataset
      dataset.each do |day|
        color_puts(
          "#{day.date}: Closed at #{day.close} (#{day.low} ~ #{day.high})",
          32
        )
      end
      first_drawdowns
      maximum_drawdown
      return_summary
    end

    def first_drawdowns
      Calculations::Drawdown.new(dataset).drawdowns.each do |drawdown|
        color_puts(
          "~ #{drawdown.percentage}% #{drawdown.peak_before_largest_drop} on "\
            "#{drawdown.peak_day} -> #{drawdown.lowest_before_new_high} on "\
            " #{drawdown.low_day}",
          31
        )
      end
    end

    def maximum_drawdown
    end

    def return_summary
    end

    private

    def color_puts(text, color)
      puts "\033[#{color}m #{text}\033[0m"
    end
  end
end

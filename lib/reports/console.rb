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
      return
      Calculations::Drawdown.new(data).drawdowns.each do |drawdown|
        color_puts(
          "#{drawdown[1]} on #{drawdown[0]} -> #{drawdown[2]} on #{drawdown[3]}",
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

# frozen_string_literal: true

require_relative '../calculations/drawdown'
require_relative '../calculations/return'

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
      put_seperator_line
      first_drawdowns
      put_seperator_line
      maximum_drawdown
      put_seperator_line
      return_summary
    end

    def first_drawdowns
      calculated_drawdowns.each do |drawdown|
        color_puts(
          drawdowm_print_template(drawdown),
          101
        )
      end
    end

    def maximum_drawdown
      maximum = calculated_drawdowns.max_by(&:percentage)
      color_puts(
        "Maximum drawdown: #{drawdowm_print_template(maximum)}",
        105
      )
    end

    def return_summary
      summary = Calculations::Return.new(dataset).return_summary
      color_puts(
        "Return:  #{summary.return_value} [+#{summary.percentage}%]"\
          "(#{summary.start_value} on #{summary.start_date} ->"\
          " #{summary.end_value} on #{summary.end_date})",
        32
      )
    end

    private

    def drawdowm_print_template(drawdown)
      "~ #{drawdown.percentage}% #{drawdown.peak_before_largest_drop} on "\
        "#{drawdown.peak_day} -> #{drawdown.lowest_before_new_high} on "\
        " #{drawdown.low_day}"
    end

    def calculated_drawdowns
      @drawdowns ||= Calculations::Drawdown.new(dataset).drawdowns
    end

    def put_seperator_line
      puts ''
      color_puts(
        '─────────────────────────────────────────────────────────'\
        '─────────────────────────',
        34
      )
      puts ''
    end

    def color_puts(text, color)
      puts "\033[#{color}m #{text}\033[0m"
    end
  end
end

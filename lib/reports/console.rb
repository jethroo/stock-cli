# frozen_string_literal: true

require_relative '../calculations/drawdown'

# simple console reporter
class Console
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def generate_report
    return unless data && data['data']
    data['data'].each do |day|
      color_puts("#{day[0]}: Closed at #{day[4]} (#{day[3]} ~ #{day[2]})", 32)
    end
    first_drawdowns
    maximum_drawdown
    return_summary
  end

  def first_drawdowns
    Drawdown.new(data).drawdowns.each do |drawdown|
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

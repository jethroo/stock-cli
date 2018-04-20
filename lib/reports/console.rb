# frozen_string_literal: true

require 'httparty'
require 'json'

# wrapper class for the quandl API
class Console
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def generate_report
    return unless data && data['data']
    data['data'].each do |day|
      puts "#{day[0]}: Closed at #{day[4]} (#{day[3]} ~ #{day[2]})"
    end
    first_drawdowns
    maximum_drawdown
    return_summary
  end

  def first_drawdowns

  end

  def maximum_drawdown

  end

  def return_summary

  end
end

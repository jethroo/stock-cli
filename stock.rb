# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'byebug'

require 'date'
require_relative 'lib/option_parsing'
require_relative 'lib/datasources/quandl'

# A tool for printing and sharing stock information from quandl.
class Stock
  attr_reader :options

  def initialize
    @options = OptionParsing.new.parse_options
  end

  def generate_report
    Quandl.new(
      options[:stock], options[:start_date], options[:end_date]
    ).pull_data
  end
end

Stock.new.generate_report

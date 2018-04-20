# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'byebug'

require 'date'
require 'optparse'

# A tool for printing and sharing stock information from quandl.
class Stock
  attr_reader :options

  def initialize
    @options = {}
    parse_options
  end

  def parse_options
    OptionParser.new do |parser|
      parser.on('--stock STOCK', 'The stock symbol') do |stock_param|
        options[:stock] = stock_param
      end

      parser.on('--begin DATE', 'The start date') do |start_date_param|
        options[:start_date] = Date.parse(start_date_param)
      end

      parser.on('--end DATE', 'The end date') do |end_date_param|
        options[:end_date] = Date.parse(end_date_param)
      end
    end.parse!
  rescue StandardError => e
    puts "Error while parsing command line params: #{e.message}"
  end

  def print_options
    puts options.inspect
  end
end

Stock.new.print_options

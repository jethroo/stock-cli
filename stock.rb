# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'byebug'

require 'date'
require_relative 'lib/option_parsing'

# A tool for printing and sharing stock information from quandl.
class Stock
  attr_reader :options

  def initialize
    @options = OptionParsing.new.parse_options
  end

  def generate_report
  end
end

Stock.new.generate_report

require 'httparty'

class Quandl
  attr_reader :ticker, :starts, :ends

  BASE_URL = 'https://www.quandl.com/api/v3/datatables/WIKI/PRICES'.freeze
  PRICES_QUERY = '?ticker=%<ticker>s&date=%<range>s&api_key=%<api_key>s'

  def initialize(ticker, starts, ends)
    @ticker = ticker
    @starts = starts
    @ends = ends
  end

  def pull_data
    return @data if @data
    response = HTTParty.get("#{BASE_URL}#{formatted_query_string}")
  end

  private

  def api_key
    @key ||= YAML.load_file(
      File.expand_path('../../secrets/quandl.yml', File.dirname(__FILE__))
    )['api_key']
  end

  def formatted_query_string
    format(PRICES_QUERY, ticker: 'APPL', range: '2018-01-01', api_key: api_key)
  end
end

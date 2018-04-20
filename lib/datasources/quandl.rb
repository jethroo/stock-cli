# frozen_string_literal: true

require 'httparty'
require 'json'

# wrapper class for the quandl API
class Quandl
  attr_reader :company_code, :starts, :ends

  BASE_URL = 'https://www.quandl.com/api/v3/datasets/EOD/'
  PRICES_QUERY = '%<company_code>s.json?start_date=%<start_date>s&end_date'\
    '=%<end_date>s&api_key=%<api_key>s&order=asc'

  def initialize(company_code, starts, ends)
    @company_code = company_code
    @starts = starts
    @ends = ends
  end

  def pull_data
    return @data if @data
    response = HTTParty.get("#{BASE_URL}#{formatted_query_string}")
    @data = response.parsed_response['dataset']
  end

  private

  def api_key
    @api_key ||= YAML.load_file(
      File.expand_path('../../secrets/quandl.yml', File.dirname(__FILE__))
    )['api_key']
  end

  def formatted_query_string
    format(PRICES_QUERY, company_code: company_code,
                         start_date: starts, end_date: ends, api_key: api_key)
  end
end

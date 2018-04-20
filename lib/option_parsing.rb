class OptionParsing
  attr_reader :parser
  attr_reader :options

  def initialize
    @options = {}
    @parser = OptionParser.new
    add_stock_option
    add_start_option
    add_end_option
  end

  def add_stock_option
    parser.on('--stock STOCK', 'The stock symbol') do |stock_param|
      options[:stock] = stock_param
    end
  end

  def add_start_option
    parser.on('--begin DATE', 'The start date') do |start_date_param|
      options[:start_date] = Date.parse(start_date_param)
    end
  end

  def add_end_option
    parser.on('--end DATE', 'The end date') do |end_date_param|
      options[:end_date] = Date.parse(end_date_param)
    end
  end

  def parse_options
    parser.parse!
    options
  rescue StandardError => e
    puts "Error while parsing command line params: #{e.message}"
  end
end

# frozen_string_literal: true

module Models
  # data class for a companies day stock market report
  class DayEntry
    ATTRIBUTES = %i[date open high low close].freeze

    attr_reader(*ATTRIBUTES)

    def initialize(data)
      ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr}", data[attr])
      end
    end
  end
end

# frozen_string_literal: true

module Calculations
  # class for calculating drawdowns in an dataset
  class Drawdown
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def drawdowns
      return unless data && data['data']
      peak_before_largest_drop = nil
      lowest_before_new_high = nil
      new_peak = false
      new_low = false
      peak_day = nil
      low_day = nil

      drawdowns = []

      data['data'].each do |day|
        if peak_before_largest_drop.nil?
          peak_before_largest_drop = day[2]
          peak_day = day[0]
          new_peak = true
        end

        if day[2] > peak_before_largest_drop
          peak_before_largest_drop = day[2]
          lowest_before_new_high = nil
          peak_day = day[0]
          new_peak = true
        end

        if lowest_before_new_high.nil?
          lowest_before_new_high = day[3]
          new_low = true
          low_day = day[0]
        end

        if lowest_before_new_high > day[3]
          lowest_before_new_high = day[3]
          new_low = true
          low_day = day[0]
        end

        if new_peak || new_low
          drawdowns << [
            peak_day, peak_before_largest_drop, lowest_before_new_high, low_day
          ]
        end

        new_low, new_peak = false
      end
      drawdowns
    end
  end
end

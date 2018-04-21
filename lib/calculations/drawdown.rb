# frozen_string_literal: true

module Calculations
  # class for calculating drawdowns in an dataset
  class Drawdown
    attr_reader :dataset, :peak_before_largest_drop, :lowest_before_new_high,
                :new_peak, :new_low, :peak_day, :low_day

    Struct.new('DrawdownSummary',
               :percentage, :peak_day, :peak_before_largest_drop,
               :lowest_before_new_high, :low_day)

    def initialize(dataset)
      @dataset = dataset
    end

    def drawdowns
      return unless dataset
      reset_calculation

      dataset.each do |day|
        check_day(day)
      end
      @drawdowns
    end

    private

    def check_day(day)
      init_peak_before_largest_drop(day)
      check_new_peak(day)
      init_lowest_before_new_high(day)
      check_new_low(day)
      add_drawdown
      @new_low, @new_peak = false
    end

    def init_peak_before_largest_drop(day)
      return unless peak_before_largest_drop.nil?
      @peak_before_largest_drop = day.high
      @peak_day = day.date
      @new_peak = true
    end

    def check_new_peak(day)
      return if day.high < peak_before_largest_drop
      @peak_before_largest_drop = day.high
      @lowest_before_new_high = nil
      @peak_day = day.date
      @new_peak = true
    end

    def check_new_low(day)
      return if lowest_before_new_high < day.low
      @lowest_before_new_high = day.low
      @new_low = true
      @low_day = day.date
    end

    def init_lowest_before_new_high(day)
      return unless lowest_before_new_high.nil?
      @lowest_before_new_high = day.low
      @new_low = true
      @low_day = day.date
    end

    def add_drawdown
      return unless new_peak || new_low
      @drawdowns << build_summary(
        [peak_day, peak_before_largest_drop, lowest_before_new_high,
         low_day]
      )
    end

    def reset_calculation
      @peak_before_largest_drop = nil
      @lowest_before_new_high = nil
      @new_peak = false
      @new_low = false
      @peak_day = nil
      @low_day = nil
      @drawdowns = []
    end

    def build_summary(values)
      Struct::DrawdownSummary.new.tap do |summary|
        summary.percentage = drawdown_in_percent(values[1], values[2])
        summary.peak_day = values[0]
        summary.peak_before_largest_drop = values[1]
        summary.lowest_before_new_high = values[2]
        summary.low_day = values[3]
      end
    end

    def drawdown_in_percent(high, low)
      (high / low * 100 - 100).round(1)
    end
  end
end

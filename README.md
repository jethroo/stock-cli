# Stock CLI

[![Build Status](https://travis-ci.org/jethroo/stock-cli.svg?branch=master)](https://travis-ci.org/jethroo/stock-cli)
[![Maintainability](https://api.codeclimate.com/v1/badges/88a6fe9ca1b61826a527/maintainability)](https://codeclimate.com/github/jethroo/stock-cli/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/88a6fe9ca1b61826a527/test_coverage)](https://codeclimate.com/github/jethroo/stock-cli/test_coverage)

A tool for printing and sharing stock information from quandl.

## Project Setup 

Requirements:
 * ruby 2.5.0
 * bundler

### Installing gems

run ```bundle install```

### Setting up API keys

In the secrets folder there are sample files like `quandl.sample.yml` which needs to be renamed to `quandl.yml` and the api_key needs to be filled with 
your real API-Key. 

## Running the programm

The program currently has 2 mandatory parameters `stock` and `start` as well
as optional `end` (if not specified the program will use today as end date). The named params have to be preceeded with `--` on the command line, as shown by the example below:

```
ruby stock.rb --stock AAPL --start 2018-01-01 --end 2018-01-05
```

The program will generate an report like: 

```
 2018-01-02: Closed at 172.26 (169.26 ~ 172.3)
 2018-01-03: Closed at 172.23 (171.96 ~ 174.55)
 2018-01-04: Closed at 173.03 (172.08 ~ 173.47)
 2018-01-05: Closed at 175.0 (173.05 ~ 175.37)

 ──────────────────────────────────────────────────────────────────────────────────

 ~ 1.8% 172.3 on 2018-01-02 -> 169.26 on  2018-01-02
 ~ 1.5% 174.55 on 2018-01-03 -> 171.96 on  2018-01-03
 ~ 1.3% 175.37 on 2018-01-05 -> 173.05 on  2018-01-05

 ──────────────────────────────────────────────────────────────────────────────────

 Maximum drawdown: ~ 1.8% 172.3 on 2018-01-02 -> 169.26 on  2018-01-02

 ──────────────────────────────────────────────────────────────────────────────────

 Return:  4.84 [+2.8%](170.16 on 2018-01-02 -> 175.0 on 2018-01-05)
```

## Running tests

run ```bundle exec rpec```

## Running rubocop

run ```bundle exec rubocop```

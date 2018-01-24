# PSS Surveys [![Build Status](https://travis-ci.org/jonatanklosko/pss_surveys.svg?branch=master)](https://travis-ci.org/jonatanklosko/pss_surveys)

A website meant for collecting feedback from competitors participating in Polish WCA competitions.

### Getting started

Requirements: Ruby 2.4 and MySQL.

- Clone the repository and cd into it: `git clone https://github.com/jonatanklosko/pss_surveys.git && cd pss_surveys`
- Install third party dependencies: `bundle install && bin/yarn`
- Create the database: `bin/rails db:setup`
- Run the server: `bin/rails server`

### Test

Run all specs with `bundle exec rspec`.

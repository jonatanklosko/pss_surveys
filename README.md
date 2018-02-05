# PSS Surveys [![Build Status](https://travis-ci.org/jonatanklosko/pss_surveys.svg?branch=master)](https://travis-ci.org/jonatanklosko/pss_surveys)

A website meant for collecting feedback from competitors participating in Polish WCA competitions.

### Getting started

Requirements: Ruby 2.4 and PostgreSQL 9.1.

- Create PostgreSQL user for the application (use *password* as password): `sudo -u postgres createuser -s pss_surveys --pwprompt`
- Clone the repository and cd into it: `git clone https://github.com/jonatanklosko/pss_surveys.git && cd pss_surveys`
- Install third party dependencies: `bundle install && bin/yarn`
- Create the database: `bin/rails db:setup`
- Run the server: `bin/rails server`

### Tests

Run all specs with `bundle exec rspec`.

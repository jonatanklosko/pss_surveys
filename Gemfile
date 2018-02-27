source "https://rubygems.org"

gem "rails", "~> 5.1.4"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "uglifier", ">= 1.3.0"
gem "turbolinks", "~> 5"
gem "rest-client", "~> 2.0", ">= 2.0.2"
gem "actionmailer-text"
gem "dotenv-rails"
gem "roo"
gem "delayed_job_active_record"
gem "daemons"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "rspec-rails", "~> 3.7"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "mailcatcher"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

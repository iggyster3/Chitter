# We need to know which database to work with
ENV["RACK_ENV"] = 'test'

# this needs too be after ENV["RACK_ENV"] = 'test'
# because the server needs to know
# what environment it's running it: test or development.
# The environment determines what dtabase to use.
require './chitter_app.rb'


require 'rack/test'
require 'capybara/rspec'
require 'database_cleaner'


Capybara.app  = Chitter

RSpec.configure do |config|

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

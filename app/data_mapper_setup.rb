env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost.
# The name will be "User_test" or "User_development" depending on the
# environment

DataMapper.setup(:default, "postgres://localhost/User_#{env}")

# This needs to be done after datamapper is initialised
require './lib/user.rb'

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables dont exist yet. Let's all datamapper to create
# them.
DataMapper.auto_upgrade!

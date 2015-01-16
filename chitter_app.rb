require 'sinatra/base'

class Chitter < Sinatra::Base

  get '/' do
    "Welcome to Rwitter"
  end

end

require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require './lib/user'
require './lib/peep'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'


class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash


  helpers CurrentUser

  set :views, Proc.new {File.join(root,"/views")}
  set :public_folder, 'public'


  get '/' do

    erb :index

  end

  post '/sign_up' do

    # Create users and send them to User_development database

    @users = User.create(:fullname => params[:fullname],
    :username => params[:username],
    :email => params[:email],
    :password => params[:password],
    :password_confirmation => params[:password_confirmation])
    @users.save

    session[:user_id] = @users.id
    @peeps = Peep.all

    erb :sign_up

    end

  post '/sessions' do
    username, password = params[:username_sign_in], params[:password_sign_in]

    user = User.authenticate(username, password)

    if user
      session[:user_id] = user.id

      @users = User.all
      @peeps = Peep.all

      erb :sign_up

    else

      flash[:errors] = ["the email or password is incorrect"]
      erb :index

    end

  end

  post '/peeps' do

    @current_user = @peeps = Peep.create(body: params[:body],
    username: params[:username],
    name: params[:name])

    @peeps.save

    @users = User.all
    @peeps = Peep.all

    erb :peeps
  end

  delete '/sessions' do

  flash[:notice] = "See you soon"
  session[:user_id] = nil
  redirect to ('/')
  end

end

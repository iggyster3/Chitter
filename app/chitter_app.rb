require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'


class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

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

  erb :sign_up

  end

  post '/sign_in' do
    erb :peeps
  end


end

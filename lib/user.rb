require 'bcrypt'
require 'data_mapper'

class User

  include DataMapper::Resource

  property :id, Serial
  property :fullname, String
  property :username, String
  property :email, String, :unique => true
  property :password, String
  property :password_confirmation, String


  property :password_token,  String
  property :password_digest, Text

end

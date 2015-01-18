require 'data_mapper'
require 'dm-timestamps'
require 'dm-validations'

class Peep

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  # This block describes what resources our model will have
  property :id,           Serial
  property :body,         Text
  property :username,    String
  property :name, 	      String
  property :created_at,   DateTime

  has 1, :user, :through => Resource

end

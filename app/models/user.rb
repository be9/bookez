class User < ActiveRecord::Base
  acts_as_authentic :login_field => "login"

  attr_protected :login

  has_many :ownerships, :dependent => :destroy
  has_many :books, :through => :ownerships

  has_many :rates
end

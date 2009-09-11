class User < ActiveRecord::Base
  has_many :predictions
end

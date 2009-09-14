class Chart < ActiveRecord::Base
  serialize :albums
  serialize :singles
end

class User < ActiveRecord::Base
  has_many :tabs, dependent: :destroy
end

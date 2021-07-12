class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_one :cart
end

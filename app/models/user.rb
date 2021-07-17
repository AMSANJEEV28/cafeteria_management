class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_one :cart

  def self.clerks
    where(role: "clerk")
  end

  def self.customers
    where(role: "customer")
  end

  def self.category(role)
    if role == "clerk"
      clerks
    else
      customers
    end
  end
end

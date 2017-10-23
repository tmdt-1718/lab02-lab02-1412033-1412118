class User < ApplicationRecord
  has_many :sendmail
  has_many :receivemail
end

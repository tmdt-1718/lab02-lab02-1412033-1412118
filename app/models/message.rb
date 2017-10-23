class Message < ApplicationRecord
  has_one :sendmail
  has_one :receivemail
end

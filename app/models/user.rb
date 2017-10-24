class User < ApplicationRecord
  has_many :sendmail
  has_many :receivemail
  has_many :confirm
  has_and_belongs_to_many(:users,
    :join_table => "friends",
    :foreign_key => "user_1_id",
    :association_foreign_key => "user_2_id")


end

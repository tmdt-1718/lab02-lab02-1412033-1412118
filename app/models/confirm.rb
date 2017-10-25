class Confirm < ApplicationRecord
  belongs_to :user, :class_name => "User", :foreign_key => "user_1_id"
end

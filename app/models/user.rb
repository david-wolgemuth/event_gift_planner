class User < ApplicationRecord
  belongs_to :event
  has_secure_password
end

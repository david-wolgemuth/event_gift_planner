class Management < ApplicationRecord
  belongs_to :manager, class_name: :User
  belongs_to :managed_user, class_name: :User

end

class User < ApplicationRecord
  belongs_to :event

  has_many :items_wishlists, dependent: :destroy
  has_many :items_in_wishlist,
    through: :items_wishlists,
    source: :item

  has_many :items_receivers, dependent: :destroy
  has_many :items_received,
    through: :items_receivers,
    source: :item

  has_many :items_givers, dependent: :destroy
  has_many :items_given,
    through: :items_givers,
    source: :item
  
  has_and_belongs_to_many :managed_users,
    join_table: :managements,
    foreign_key: :manager_id,
    association_foreign_key: :managed_user_id,
    class_name: :User

  has_and_belongs_to_many :managers,
    join_table: :managements,
    foreign_key: :managed_user_id,
    association_foreign_key: :manager_id,
    class_name: :User

  has_secure_password

  def other_users_in_event
    event.users.where.not(id: id)
  end

end

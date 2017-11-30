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

  has_secure_password

  def other_users_in_event
    event.users.where.not(id: id)
  end

end

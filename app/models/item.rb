class Item < ApplicationRecord
  has_many :items_givers, dependent: :destroy
  has_many :givers, through: :items_givers, source: :user

  has_many :items_receivers, dependent: :destroy
  has_many :receivers, through: :items_receivers, source: :user

  has_many :items_wishlists, dependent: :destroy

end

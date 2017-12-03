class Item < ApplicationRecord
  has_many :items_givers, dependent: :destroy
  has_many :givers, through: :items_givers, source: :user

  has_many :items_receivers, dependent: :destroy
  has_many :receivers, through: :items_receivers, source: :user

  has_many :items_wishlists, dependent: :destroy

  include ActionView::Helpers::NumberHelper

  def price_display
    if price.blank? || price.zero?
      return ''
    end
    precision = (price == price.round) ? 0 : 2  # (if no cents, don't show .00)
    number_to_currency(price, precision: precision)
  end

end

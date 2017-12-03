class ListsController < ApplicationController
  helper_method :recipient

  def recipient
    items = recipient.items_in_wishlist.includes(:givers).load
    recipient.items_received.includes(:givers).load
  end

  def wishlist
    current_user.items_in_wishlist.load
    current_user.items_given.load
  end

  def create_wishlist_item
    # create item for user, or managed user if applicable
    # 
    user = current_user_or_managed_user
    user.items_in_wishlist.create(item_params)
    redirect_to current_user_or_managed_user_path
  end

  def edit_wishlist_item
    # create item for user, or managed user if applicable
    # 
    user = current_user_or_managed_user
    item = user.items_in_wishlist.find(params[:id])
    item.update(item_params)
    redirect_to current_user_or_managed_user_path
  end

  def create_purchased_item
    item = current_user.items_given.create(item_params)
    recipient.items_received.append(item)
    redirect_to lists_path(event_params.merge(username: recipient.username))
  end

  def remove_item_from_wishlist
    # removes item from user's wishlist (or managed user)
    #   - if no one has purchased, item is destroyed
    # 
    user = current_user_or_managed_user
    item = user.items_in_wishlist.find(params[:id])
    user.items_in_wishlist.delete(item)
    if item.givers.blank?
      item.destroy
    end
    redirect_to current_user_or_managed_user_path 
  end

  def mark_item_purchased
    item = recipient.items_in_wishlist.find_by_id(params[:item_id]) ||
           recipient.items_received.find_by_id(params[:item_id]) ||
           current_user.items_given.find_by_id(params[:item_id])

    item.givers.append(current_user) if item.givers.exclude?(current_user)
    item.receivers.append(recipient) if item.receivers.exclude?(recipient)

    redirect_to lists_path(event_params.merge(username: recipient.username))
  end

  def mark_item_not_purchased
    item = recipient.items_in_wishlist.find_by_id(params[:item_id]) ||
           recipient.items_received.find_by_id(params[:item_id])

    item.receivers.delete(recipient) if item.givers.all?{|u| u == current_user}
    item.givers.delete(current_user) if item.receivers.all?{|u| u == recipient}

    redirect_to lists_path(event_params.merge(username: recipient.username))
  end

private

  def current_user_or_managed_user
    managed_user || current_user
  end

  def current_user_or_managed_user_path
    (managed_user.present?) ?
    lists_path(event_params.merge(username: managed_user.username)) : wishlist_path(event_params)
  end

  def managed_user
    current_user.managed_users.find_by_id(params[:managed_user_id])
  end

  def recipient
    current_user.other_users_in_event.find_by_username(params[:username])
  end

  def item_params
    params.require(:item).permit(:title, :image_url, :listing_url, :price, :notes)
  end

end

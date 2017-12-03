Rails.application.routes.draw do
  
  scope '/:event' do
    get '/' => 'events#show', as: :event

    scope '/lists', controller: :Lists do

      get '/wishlist' => 'lists#wishlist'
      get '/:username' => 'lists#recipient', as: :lists

      post '/wishlist_item' => 'lists#create_wishlist_item'
      post '/purchased_item' => 'lists#create_purchased_item'

      put '/wishlist_item/:id' => 'lists#edit_wishlist_item', as: :edit_wishlist_item

      delete '/wishlist_item/:id' => 'lists#remove_item_from_wishlist', as: :remove_item_from_wishlist

      post '/mark_item_purchased' => 'lists#mark_item_purchased'
      post '/mark_item_not_purchased' => 'lists#mark_item_not_purchased'

    end

    scope '/users', controller: :Users do

      get '/login' => 'users#login'
      get '/logout' => 'users#logout'
      post '/authenticate' => 'users#authenticate'

    end

    match '*path' => 'events#show', via: :get
  end

  root 'events#index'
  match '*path', to: redirect('/'), via: :get

end

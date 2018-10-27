Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :playlists do
    resources :playlist_items
  end
  resources :playlist_items
  resources :artists
  resources :tracks
end

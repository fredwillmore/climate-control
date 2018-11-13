Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :playlists do
    get 'playlist_items/first', to: 'playlists/playlist_items#first'
    get 'playlist_items/last', to: 'playlists/playlist_items#last'
    get 'playlist_items/:id/next', to: 'playlists/playlist_items#next'
    get 'playlist_items/:id/previous', to: 'playlists/playlist_items#previous'
    resources :playlist_items, controller: 'playlists/playlist_items'
  end
  resources :playlist_items
  resources :artists
  resources :tracks
end

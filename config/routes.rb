Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/show'
  get 'rooms/new'
  get 'rooms/create'
  get 'rooms/edit'
  get 'rooms/update'
  get 'rooms/destroy'
  root "rooms#index"

  resources :rooms do
    resources :items, except: [:show]
    resources :boxes, except: [:show]
  end

  resources :items, only: [:show, :edit, :update, :destroy] do
    collection do
      get :search
    end
  end

  resources :boxes, only: [:show, :edit, :update, :destroy] do
    member do
      get :label
    end
    collection do
      get :search
    end
  end
end

Rails.application.routes.draw do
  devise_for :users

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

  resources :users, only: [] do
    member do
      get 'my_account'
    end
  end

end

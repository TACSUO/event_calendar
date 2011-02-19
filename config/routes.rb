Rails.application.routes.draw do
  root :to => "events#index"
  resources :events do
    collection do
      get :search
    end
    resources :attendees
    resources :links
  end
  resources :event_revisions do
    member do
      post :restore
    end
  end
end

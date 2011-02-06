Rails.application.routes.draw do
  root :to => "events#index"
  resources :events do
    resources :attendees
    resources :links
  end
  resources :event_revisions do
    member do
      post :restore
    end
  end
end

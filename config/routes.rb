Rails.application.routes.draw do
  resource :chat, only: [:new, :create, :show] do
    get ":uuid", action: :show, on: :member, as: :show_by_uuid
  end
  resources :messages, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "chats#new"
end

Rails.application.routes.draw do
  get 'users/signup', to: 'users#new', as: 'signup'
  get 'staticpages/top'
  get 'staticpages/about'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

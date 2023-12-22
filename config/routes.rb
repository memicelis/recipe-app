Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'

  resources :recipes, only: [:index, :show, :create, :new, :destroy, :update] do
    resources :recipe_foods, except: :update
  end

  resources :foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :shopping_lists, only: [:index]
end

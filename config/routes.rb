Rails.application.routes.draw do
  get 'recipe_foods/new'
  get 'recipe_foods/create'
  get 'recipe_foods/destroy'
  devise_for :users
  root 'public_recipes#index'

  resources :recipes, only: [:index, :show, :create, :new, :destroy, :update] do
    resources :recipe_foods, except: :update
  end

  resources :foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :shopping_lists, only: [:index]
end

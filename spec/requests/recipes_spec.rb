require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(name: 'Elis', email: 'elis@elis.com', password: 'password') }
  let(:recipe) do
    user.recipes.create(name: 'Test Recipe', cooking_time: 30, preparation_time: 15, description: 'Test description',
                        public: true)
  end

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get recipes_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_recipe_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get recipe_path(recipe.id)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new recipe' do
        recipe_params = {
          recipe: {
            name: 'Test Recipe',
            cooking_time: 30,
            preparation_time: 15,
            description: 'Test description',
            public: true
          }
        }

        expect { post recipes_path, params: recipe_params }.to change { Recipe.count }.by(1)
        expect(response).to redirect_to(recipe_path(assigns(:recipe).id))
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:recipe) do
      user.recipes.create(name: 'Test Recipe', cooking_time: 30, preparation_time: 15, description: 'Test description',
                          public: true)
    end
    it 'destroys the recipe' do
      expect { delete recipe_path(recipe.id) }.to change { Recipe.count }.by(-1)
      expect(response).to redirect_to(recipes_path)
    end
  end
end

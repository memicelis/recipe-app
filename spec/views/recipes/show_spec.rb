require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  let(:user) { User.new(name: 'Elis', email: 'elis@elis.com', password: 'password') }
  let(:recipe) do
    Recipe.new(
      user:,
      name: 'Recipe',
      preparation_time: 2,
      cooking_time: 1,
      description: 'Recipe Description',
      public: true
    )
  end
  let(:ingredient) do
    RecipeFood.new(
      recipe:,
      food: user.foods.create(name: 'Test Food', measurement_unit: 'kg', price: 10, quantity: 2, user:), quantity: 1
    )
  end

  before do
    user.save
    sign_in user
    recipe.save
    ingredient.save
    visit recipe_path(recipe)
  end

  describe 'show' do
    it 'renders a page' do
      expect(page).to have_content(recipe.name)
      expect(page).to have_link('Add Ingredient')

      within 'table' do
        expect(page).to have_content(ingredient.food.name)
        expect(page).to have_content("#{ingredient.quantity} #{ingredient.food.measurement_unit}")
        expect(page).to have_button('Delete')
      end
    end
  end
end

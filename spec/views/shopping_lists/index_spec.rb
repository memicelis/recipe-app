require 'rails_helper'

RSpec.describe 'Shopping List', type: :feature do
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
      food: user.foods.create(name: 'Test Food', measurement_unit: 'kg', price: 10, quantity: 2, user:), quantity: 4
    )
  end

  before do
    user.save
    sign_in user
    recipe.save
    ingredient.save
    visit shopping_lists_path
  end

  describe 'index' do
    it 'displays the shopping list with missing food items' do
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Total Food Items: 1')
      expect(page).to have_content('Total Price: $20.00')

      within 'table' do
        expect(page).to have_content('Food')
        expect(page).to have_content('Quantity')
        expect(page).to have_content('Price')

        expect(page).to have_content('Test Food')
        expect(page).to have_content('2 kg')
        expect(page).to have_content('$20.00')
      end
    end
  end
end

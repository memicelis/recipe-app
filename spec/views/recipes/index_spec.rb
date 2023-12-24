require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  let(:user) { User.new(name: 'Elis', email: 'elis@elis.com', password: 'password') }
  let(:recipe) do
    Recipe.new(user:, name: 'Recipe', preparation_time: 2, cooking_time: 1,
               description: 'Recipe Description', public: true)
  end

  before do
    user.save
    recipe.save
    sign_in user
    visit recipes_path
  end

  describe 'index' do
    it 'renders a page' do
      expect(page).to have_content('Recipes')
      expect(page).to have_link('Add New Recipe')

      expect(page).to have_content(recipe.name)
      expect(page).to have_content(recipe.description)
      expect(page).to have_button('Delete')
    end
  end
end

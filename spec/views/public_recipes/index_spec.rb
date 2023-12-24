require 'rails_helper'

RSpec.describe 'Public Recipes', type: :feature do
  let(:user) { User.new(name: 'Elis', email: 'elis@elis.com', password: 'password') }
  let(:recipe1) do
    Recipe.new(user:, name: 'Recipe', preparation_time: 2, cooking_time: 1,
               description: 'Recipe Description', public: true)
  end
  let(:recipe2) do
    Recipe.new(user:, name: 'Recipe 2', preparation_time: 2, cooking_time: 1,
               description: 'Recipe Description', public: false)
  end

  before do
    user.save
    recipe1.save
    recipe2.save
    sign_in user
    visit root_path
  end

  describe 'index' do
    it 'renders a page' do
      expect(page).to have_content('Public recipes')

      expect(page).to have_content(recipe1.name)
      expect(page).to have_content('Total Price')
      expect(page).to have_content('Total Food Items')

      expect(page).not_to have_content(recipe2.name)
    end
  end
end
